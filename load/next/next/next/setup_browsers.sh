RAINDROP_URL_CHROME=https://chromewebstore.google.com/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien
RAINDROP_URL_FIREFOX=https://addons.mozilla.org/en-US/firefox/addon/raindropio/

REACT_DEV_TOOLS_URL_CHROME=https://chromewebstore.google.com/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi

PERFECT_PIXEL_URL_CHROME=https://chromewebstore.google.com/detail/perfectpixel-by-welldonec/dkaagdgjmgdmbnecmcefdhjekcoceebi

GOOGLE_URL=https://www.google.com/

GITHUB_URL=https://github.com/NikolaiKotikov?tab=repositories

prompt "Open browsers and configure"

run_in_background google-chrome "$RAINDROP_URL_CHROME" "$GITHUB_URL"
run_in_background chromium-browser "$REACT_DEV_TOOLS_URL_CHROME" "$PERFECT_PIXEL_URL_CHROME"
run_in_background firefox "$GOOGLE_URL" "$GITHUB_URL" "$RAINDROP_URL_FIREFOX"
