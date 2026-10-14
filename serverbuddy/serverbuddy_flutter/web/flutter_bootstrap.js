{{flutter_js}}
{{flutter_build_config}}

// Load without a service worker: the voice app should always run the latest
// build rather than a cached copy.
_flutter.loader.load();
