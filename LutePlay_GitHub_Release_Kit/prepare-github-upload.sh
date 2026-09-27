#!/usr/bin/env bash
# Bryce Industries / LutePlay: collect the three *real* files built on your PC.
# This does not build software or change the installed LutePlay application.
set -Eeuo pipefail
SOURCE="${1:-$HOME/Downloads/LutePlay_Linux_Build_Kit_Fixed/output}"
DEST="${2:-$HOME/Downloads/LutePlay_GitHub_Upload}"
DEB='luteplay_0.1.0~dev_amd64.deb'
TAR='luteplay_0.1.0-dev_linux_amd64.tar.gz'
SUMS='SHA256SUMS'
fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
[[ -d "$SOURCE" ]] || fail "Build output folder missing: $SOURCE"
for name in "$DEB" "$TAR" "$SUMS"; do
    [[ -f "$SOURCE/$name" ]] || fail "Missing $name in $SOURCE"
done
command -v sha256sum >/dev/null || fail 'sha256sum is required.'
command -v dpkg-deb >/dev/null || fail 'dpkg-deb is required.'
# Verify BEFORE copying, so corrupt files never appear in a ready-to-upload folder.
(cd "$SOURCE" && sha256sum --check --strict "$SUMS") || fail 'Build file checksum verification failed.'
[[ "$(dpkg-deb --field "$SOURCE/$DEB" Package)" == 'luteplay' ]] || fail 'Installer is not a LutePlay package.'
[[ "$(dpkg-deb --field "$SOURCE/$DEB" Version)" == '0.1.0~dev' ]] || fail 'Unexpected .deb version.'
[[ "$(dpkg-deb --field "$SOURCE/$DEB" Architecture)" == 'amd64' ]] || fail 'Expected an amd64 Linux installer.'
tar -tzf "$SOURCE/$TAR" | grep '/run-luteplay.sh$' >/dev/null || fail 'Portable archive is missing its launch script.'
[[ "$(realpath -m "$SOURCE")" != "$(realpath -m "$DEST")" ]] || fail 'Destination cannot be source folder.'
# The destination must contain only the THREE checked assets.
if [[ -e "$DEST" ]] && [[ -n "$(ls -A "$DEST" 2>/dev/null)" ]]; then
    fail "Destination already contains files: $DEST. Move or remove it first; nothing was overwritten."
fi
mkdir -p "$DEST"
cp -- "$SOURCE/$DEB" "$SOURCE/$TAR" "$SOURCE/$SUMS" "$DEST/"
(cd "$DEST" && sha256sum --check --strict "$SUMS") || fail 'Copied files failed checksum verification.'
printf '\nREADY: These are the ONLY three files to upload as GitHub Release assets:\n'
ls -lh -- "$DEST/$DEB" "$DEST/$TAR" "$DEST/$SUMS"
printf '\nFolder: %s\n' "$DEST"
printf 'GitHub releases: https://github.com/brycegeorge37-droid/Bryce-Industries-Software/releases/new\n'
printf '\nIMPORTANT: Upload these files to a GitHub *Release*, not to the repository Code page.\n'
