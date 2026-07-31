{
  writeShellApplication,
  curl,
  coreutils,
  spotify,
  wl-clipboard,
}:
writeShellApplication {
  name = "spotify-jam";

  runtimeInputs = [
    curl
    coreutils
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

    resolved="$(curl -sIL --max-time 20 -o /dev/null -w '%{url_effective}' -- "$link")"

    if [ -z "$resolved" ]; then
      echo "spotify-jam: could not resolve $link" >&2
      exit 1
    fi

    case "$resolved" in
      *spotify.app.link*)
        enc="''${resolved##*full_url=}"
        enc="''${enc%%&*}"
        if [ -n "$enc" ] && [ "$enc" != "$resolved" ]; then
          resolved="$(printf '%b' "''${enc//%/\\x}")"
        fi
        ;;
    esac

    case "$resolved" in
      http://open.spotify.com/* | https://open.spotify.com/*) ;;
      *)
        echo "spotify-jam: resolved to $resolved" >&2
        echo "spotify-jam: that is not an open.spotify.com link, giving up" >&2
        exit 1
        ;;
    esac

    path="''${resolved#*://open.spotify.com/}"
    path="''${path%%\?*}"
    path="''${path%%#*}"
    path="''${path#intl-*/}"

    uri="spotify:''${path//\//:}"

    echo "link    : $resolved"
    echo "opening : $uri"

    exec spotify "$uri"
  '';
}
