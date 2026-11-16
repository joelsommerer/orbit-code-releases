#!/bin/sh
# Orbit Code installer for macOS (Apple chip).
#   curl -fsSL https://joelsommerer.github.io/orbit-code-releases/install.sh | sh
# Downloads the latest release, puts "Orbit (Beta).app" into Applications and starts it.
# Run it again to update; your data in ~/.orbit stays.
#
# ORBIT_INSTALL_DIR=<folder>  install somewhere else (Orbit is then left running)
# ORBIT_NO_OPEN=1             do not start Orbit afterwards
set -eu

REPO="joelsommerer/orbit-code-releases"
APP="Orbit (Beta).app"
PROCESS="Orbit (Beta)"
# pgrep reads a pattern; the brackets in the name must not count as a regex group.
PROCESS_PATTERN='Orbit \(Beta\)'

say() { printf '%s\n' "$*"; }
fail() {
  printf 'Orbit Code: %s\n' "$*" >&2
  exit 1
}

[ "$(uname -s)" = "Darwin" ] || fail "this installer is for macOS."
[ "$(uname -m)" = "arm64" ] || fail "Orbit Code needs a Mac with an Apple chip (M1 or newer)."

say "Looking for the latest Orbit Code release..."
release=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest") ||
  fail "could not reach GitHub. Check your connection and try again."
url=$(printf '%s' "$release" |
  grep -o '"browser_download_url": *"[^"]*-arm64\.zip"' |
  head -n 1 |
  sed 's/.*"\(https[^"]*\)"$/\1/')
version=$(printf '%s' "$release" | grep -o '"tag_name": *"[^"]*"' | head -n 1 | sed 's/.*"\([^"]*\)"$/\1/')
[ -n "$url" ] || fail "the latest release has no download for Apple chips."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

say "Downloading Orbit Code $version..."
curl -fL --progress-bar "$url" -o "$tmp/orbit.zip" || fail "the download failed."
ditto -x -k "$tmp/orbit.zip" "$tmp/unpacked" || fail "the download could not be unpacked."
[ -d "$tmp/unpacked/$APP" ] || fail "the download does not contain $APP."

if [ -n "${ORBIT_INSTALL_DIR:-}" ]; then
  dest="$ORBIT_INSTALL_DIR"
  mkdir -p "$dest"
else
  dest="/Applications"
  if [ ! -w "$dest" ]; then
    dest="$HOME/Applications"
    mkdir -p "$dest"
  fi
  # A running Orbit would crash when its files are replaced.
  if pgrep -xq "$PROCESS_PATTERN"; then
    say "Quitting Orbit Code to update it..."
    osascript -e "quit app \"$PROCESS\"" >/dev/null 2>&1 || true
    waited=0
    while pgrep -xq "$PROCESS_PATTERN" && [ "$waited" -lt 30 ]; do
      sleep 1
      waited=$((waited + 1))
    done
    pgrep -xq "$PROCESS_PATTERN" && fail "Orbit Code is still running. Quit it and run the installer again."
  fi
fi

rm -rf "$dest/$APP"
ditto "$tmp/unpacked/$APP" "$dest/$APP" || fail "could not write to $dest."
# Downloads with curl are not quarantined, but an older copy may still carry the flag.
xattr -dr com.apple.quarantine "$dest/$APP" 2>/dev/null || true

say "Orbit Code $version is installed in $dest."
if [ -z "${ORBIT_NO_OPEN:-}" ]; then
  open "$dest/$APP"
fi
