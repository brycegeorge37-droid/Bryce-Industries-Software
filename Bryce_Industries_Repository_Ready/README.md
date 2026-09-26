# Bryce Industries Software

Company software development and official website.

- `website/public/` contains only the public website assets: homepage, corporate insignia, site settings, and the public software update manifest.
- `website/wrangler.jsonc` configures deployment to the existing `bryce-industries` Cloudflare Worker.
- LutePlay and future software projects can live under `software/` later.
- Publish tested installers through GitHub Releases, not inside `website/public/`.

## Cloudflare setup
Connect this repository to the existing `bryce-industries` Worker, set the root directory to `website` (without a leading slash), use the production branch `main`, leave build command blank, and use `npx wrangler deploy` as the deployment command.

No platform download links or PayPal contribution URL are active until genuine tested binaries and an official business contribution link have been added.
