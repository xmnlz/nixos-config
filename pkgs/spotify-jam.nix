{
  writeShellApplication,
  curl,
  coreutils,
  gnugrep,
  gnused,
  spotify,
  wl-clipboard,
}:
# Open a Spotify Jam (or any share) link in the desktop client instead of the
# browser.
#
# Spotify's page attempts it by pointing a hidden iframe at a spotify:// URI,
# then unconditionally redirecting to the "get the app" page. Firefox blocks
# external-protocol loads from an iframe without user activation, so the
# redirect always wins.
#
# This sidesteps the browser entirely: it reads the deep link Spotify itself
# embedded in the page and hands it straight to the client.
writeShellApplication {
  name = "spotify-jam";

  runtimeInputs = [
    curl
    coreutils
    gnugrep
    gnused
    spotify
    wl-clipboard
  ];

  text = ''
    link="''${1:-}"

    if [ -z "$link" ]; then
      link="$(wl-paste 2>/dev/null | tr -d '[:space:]' || true)"
    fi

    if [ -z "$link" ]; then
      echo "usage: spotify-jam <https://spotify.link/... | https://open.spotify.com/...>" >&2
      echo "       with no argument, the link is read from the clipboard" >&2
      exit 1
    fi

    ua='Mozilla/5.0 (X11; Linux x86_64; rv:133.0) Gecko/20100101 Firefox/133.0'

    # spotify.link is a Branch.io shortener; follow it to the canonical URL.
    resolved="$(curl -sIL --max-time 20 -A "$ua" -o /dev/null -w '%{url_effective}' -- "$link")"

    if [ -z "$resolved" ]; then
      echo "spotify-jam: could not resolve $link" >&2
      exit 1
    fi

    case "$resolved" in
      http://open.spotify.com/* | https://open.spotify.com/*) ;;
      *)
        echo "spotify-jam: resolved to $resolved" >&2
        echo "spotify-jam: that is not an open.spotify.com link, giving up" >&2
        exit 1
        ;;
    esac

    # The page carries the deep link Spotify would hand to the app on
    # macOS/Android, base64-encoded in a urlSchemeConfig blob. Prefer it over
    # reconstructing the URI ourselves: it is exactly what the app expects,
    # tracking parameters and all.
    uri="$(
      curl -sL --compressed --max-time 20 -A "$ua" -- "$resolved" \
        | grep -o 'id="urlSchemeConfig"[^>]*>[^<]*' \
        | sed 's/.*>//' \
        | base64 -d 2>/dev/null \
        | sed -n 's/.*"urlScheme":"\([^"]*\)".*/\1/p' || true
    )"

    if [ -z "$uri" ]; then
      rest="''${resolved#*://open.spotify.com/}"
      rest="''${rest#intl-*/}"
      uri="spotify://$rest"
    fi

    echo "link    : $resolved"
    echo "opening : $uri"

    exec spotify "$uri"
  '';
}
