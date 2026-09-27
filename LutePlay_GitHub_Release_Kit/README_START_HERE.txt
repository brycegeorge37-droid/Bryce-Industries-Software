BRYCE INDUSTRIES: LUTEPLAY 0.1.0-dev GITHUB RELEASE KIT

This kit does NOT contain installers. The real Linux installers were already
built and tested on your Kubuntu computer. The helper copies them into one
clean folder, validates SHA-256 checksums, and verifies basic package metadata.
It leaves your working Python code and existing build output untouched.

1. Extract this ZIP in Downloads.
2. Open Konsole and run:

   bash "$HOME/Downloads/LutePlay_GitHub_Release_Kit/prepare-github-upload.sh"

   If extraction produces a different folder name, open the extracted folder
   in Dolphin and use its actual path instead.

3. On success, Dolphin can open the upload-ready folder:

   dolphin "$HOME/Downloads/LutePlay_GitHub_Upload"

   It will contain EXACTLY three real, tested-build files:
   - luteplay_0.1.0~dev_amd64.deb
   - luteplay_0.1.0-dev_linux_amd64.tar.gz
   - SHA256SUMS

4. Open:
   https://github.com/brycegeorge37-droid/Bryce-Industries-Software/releases/new

   Tag: luteplay-v0.1.0-dev
   Release title: LutePlay 0.1.0-dev — Linux Beta
   Target: main
   Check: Set as a pre-release
   Copy the contents of RELEASE_NOTES.md into the release description.
   Upload the THREE files from LutePlay_GitHub_Upload to the release's
   'Attach binaries' area. Do NOT add them on the repository Code page.
   Then publish the prerelease after confirming all three are attached.

5. Verify the published release downloads on GitHub before you update the site.
   AFTER_RELEASE/updates.json is the replacement manifest for the website
   *after* publishing and testing the GitHub release download link.
   In your GitHub repository, edit the EXISTING file at:
   Bryce_Industries_Repository_Ready/website/public/updates.json
   Paste the contents of AFTER_RELEASE/updates.json and commit on main.
   (If you moved your website folder, locate its actual updates.json instead.)
   Your existing Cloudflare Git integration should then publish the update.

NOTE: This is a Linux x86-64 beta tested on your Kubuntu computer. It requires
system VLC and may not work on older Linux distributions with older glibc.
Do not describe it as an AppImage or a generally verified Linux release.
The website's Windows and macOS download buttons remain disabled.
