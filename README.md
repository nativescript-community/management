# Management

Tools used with GitHub Actions to help maintain Community plugins. This creates a GitHub Action called `Update Plugins` where up to three different commands can be ran across all supported plugins: `Update Submodules`, `Sync Common Files`, and `Build Plugin Test`.

## Currently Supported Repos

- [x] algolia
- [x] arraybuffers
- [x] ble
- [ ] css-theme
- [ ] extendedinfo
- [ ] flipper
- [ ] fonticon
- [x] geocoding
- [x] gesturehandler
- [x] gps
- [x] https
- [ ] insomnia
- [ ] l
- [ ] licenses
- [x] md5
- [x] motion-activity
- [ ] nativescript-drawingpad
- [ ] nativescript-health-data
- [ ] observable
- [x] perms
- [x] plugin-seed
- [x] preferences
- [ ] push
- [x] sensors
- [x] sentry
- [x] sqlite
- [x] systemui
- [x] text
- [ ] texttospeech
- [ ] tween
- [x] ui-barcodeview
- [ ] ui-blurview
- [x] ui-cameraview
- [x] ui-canvas
- [x] ui-carto
- [x] ui-chart
- [x] ui-checkbox
- [x] ui-collectionview
- [x] ui-document-picker
- [x] ui-drawer
- [x] ui-image
- [x] ui-label
- [x] ui-lottie
- [ ] ui-mapbox
- [x] ui-material-components
- [x] ui-pager
- [x] ui-persistent-bottomsheet
- [x] ui-popover
- [x] ui-pulltorefresh
- [x] ui-share-file
- [ ] ui-social-share
- [x] ui-svg
- [x] ui-webview
- [x] universal-links
## Running

The GitHub Action can only be ran from a manual trigger. 

To run the workflow:
1. Go to the `Actions` tab for this repo.
1. On the left sidebar, select the workflow `Update Plugins`.
1. Click the `Run workflow` button on the right side of the page.
1. Configure workflow options (by default it will `Update Submodules`, `Sync Common Files`, and `Build Plugin Test`) and then click `Run workflow`.
1. Click on the running workflow once it appears.
1. You will now be able to see each individual process running for each plugin. If anything fails, you will be able to go into the specific job to see more details.

## Commands
### Update Submodules

Will clone each supported plugin repo and find all of the submodules it is using and update them to the latest `master` branch. The changes will then be committed and pushed.

### Sync Common Files

Will clone each supported plugin repo and run `npm run sync` from the plugin's root. This will copy over all of the standard files from `./tools/common` as well as update the `scripts` portion for the `package.json` (as well as some other little things).

### Build Plugin Test

Will clone each supported plugin repo, install its dependencies, and build the plugin using either `npm run build.all` or `npm run build`.

## Add/Remove Plugin Repos

To add/remove a plugin from being in the default list of supported plugin repos, simply edit the YML file [here](.github/workflows/update.yml#L22). 