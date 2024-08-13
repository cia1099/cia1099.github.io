'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "bd107544ef20491134192dd462b3b816",
"icons/Icon-192.png": "880ff3d10f37471e908c96923a612dca",
"icons/Icon-512.png": "bd107544ef20491134192dd462b3b816",
"icons/Icon-maskable-192.png": "880ff3d10f37471e908c96923a612dca",
"roadmap_cv.html": "5f7a33521e8d6724ecac5d6230ad1001",
"assets/FontManifest.json": "daf1f817658c2d4328a27ae7e3af9150",
"assets/AssetManifest.bin.json": "b6af2bbc30e835a4a7194155b7abfce7",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/assets/images/logo_cpp.png": "0b849c72f38362fe12072a4916660013",
"assets/assets/images/ios.webp": "160cd75ea514f654d31ec4d6d8ffca24",
"assets/assets/images/cv.gif": "e96473185433f16eb9b1ff29f1a2539e",
"assets/assets/images/portfolio_icon.png": "abf0d7c609acf8a5b4347fa369d7f165",
"assets/assets/images/people_counting.png": "a70248c6ef1684b0c0dd7446aeca2d4d",
"assets/assets/images/cpp.jpeg": "c9de1c8ce3e81caa6111e5e9f2cf9ba5",
"assets/assets/images/newbackground.png": "33dbad61022455f26ca0fa886b4657a1",
"assets/assets/images/logo_swift.png": "cfb294e874c8a683617e9438156dc352",
"assets/assets/images/3dGaze.webp": "2258d66810199d0e77bc414181daa494",
"assets/assets/images/logo_cv.png": "fca9d4d8cedb30a9fe7cf58d4c802a18",
"assets/assets/images/git.png": "c90edd3c28a777dfacdc8ab6ef33272b",
"assets/assets/images/logo_git.png": "2d78f49311cf0c079ea8aa1cae1a9de4",
"assets/assets/images/flutter-development.jpeg": "ef00df34fb1aa7f2ddaffc53bcdfe2c5",
"assets/assets/images/logo_python.png": "1138d636528820dc1f59149610ab400b",
"assets/assets/images/cover.jpg": "e1e4b2e46b8d6eabb7330afb0c0d30ff",
"assets/assets/images/python-fastapi.jpg": "e8d0dbadaf6becc8610ae7831a169b37",
"assets/assets/langs/langs.yaml": "d03de8b8e70c453ed1881855a65b8097",
"assets/fonts/Electrolize-Regular.ttf": "1be3e0aaeb2bbd1985615a49da7f2eaf",
"assets/fonts/MaterialIcons-Regular.otf": "1019d9d700ffd5c198eb9379912631fc",
"assets/fonts/Montserrat-Regular.ttf": "ee6539921d713482b8ccd4d0d23961bb",
"assets/AssetManifest.bin": "0b3416c2c896a00f293dea67dbe0694c",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "ffd063c5ddbbe185f778e7e41fdceb31",
"assets/packages/roulette/assets/outside_bowl.png": "77dbb862156be4e48e271db72a529827",
"assets/packages/roulette/assets/roulette.png": "2dc853d3d77abca02a107fa558d4705c",
"assets/packages/fast_furious/assets/car02.png": "68fa0c86b266d168389535bdbf72319e",
"assets/packages/fast_furious/assets/car07.png": "ef6b34b3b89d44ce782c2f7587991413",
"assets/packages/fast_furious/assets/car01.png": "8cc80d605e65bbb575b6d80c900a28c2",
"assets/packages/fast_furious/assets/car06.png": "42353b7b03d56e94c3c39e5a5a15aea5",
"assets/packages/fast_furious/assets/car08.png": "f7eef25c836cbb22f4f153450212798f",
"assets/packages/fast_furious/assets/car00.png": "1205a1e7627538899b5ec0be2ed0c00e",
"assets/packages/fast_furious/assets/goal.png": "4c8ee65a4ad461457b9e7f6d3ccec6f8",
"assets/packages/fast_furious/assets/car05.png": "266f122adcf6490b4c8d2f2e9fc857b2",
"assets/packages/fast_furious/assets/start.png": "5da619c73fa52f8bf8147965ce708c1e",
"assets/packages/fast_furious/assets/car04.png": "2bd15b14ff64cd135a630b060a730bf5",
"assets/packages/fast_furious/assets/car03.png": "be7d326814e382c5a2c113f313a13c6a",
"assets/packages/fast_furious/assets/car09.png": "3e0fcae415cfbcf86cfe6f7c174dead6",
"assets/packages/slot_machine_roller/assets/slot6.png": "1904030e0d6391217c773f1220512e59",
"assets/packages/slot_machine_roller/assets/slot5.png": "7de56f48c0b38c6bbc2c155bf606689a",
"assets/packages/slot_machine_roller/assets/slot1.png": "15a9f2a8ece4fe6fc29c456924b42f21",
"assets/packages/slot_machine_roller/assets/slot3.png": "4bc912b9b07bd367e5a690577ddbe3b2",
"assets/packages/slot_machine_roller/assets/machine.png": "606074c05e0b711f60fd5a6d615d1c86",
"assets/packages/slot_machine_roller/assets/slot4.png": "b647ef8ba0170addb1b47d54bf8910f2",
"assets/packages/slot_machine_roller/assets/slot2.png": "fa8c24b22a489bcafc5da69b9bf47bf5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "9328cd03662db86bde677cf0dcc94200",
"assets/AssetManifest.json": "72f985ed5c00a16b875b7a8ae6b5b772",
"assets/NOTICES": "f791db9754ca1a8e462bd455b3f7800b",
"index.html": "5b20017ab880ca8db7af23c11b3d8d89",
"/": "5b20017ab880ca8db7af23c11b3d8d89",
"main.dart.js": "d9adbee04e33a8d45275527e258da485",
"favicon.png": "79fbe5b05a1fa5a7db9897d077d20712",
"version.json": "009c9e65172e010890f7f65fde438006",
"turnstile.html": "47320cfde63e4bb33236024cf3e61123",
"roadmap_git.html": "27a6ef85c5a398f8672bca7716c27ead",
"roadmap_full_stack.html": "848418eb419e294405cf771a748f5356",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"manifest.json": "cd7a31e869734e249c887c0110402ae1",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
