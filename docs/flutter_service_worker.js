'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "cb23685137c00fff4317f655bcfda152",
"assets/AssetManifest.bin.json": "e83aa08b2c1979689d6b840c33f9c8ba",
"assets/assets/icons/dart.svg": "df2c4f639b1c7af47c451faba203efe5",
"assets/assets/icons/docker.svg": "821dd9b9539fec133ac7de74512b79ec",
"assets/assets/icons/flutter.svg": "fdb46fc7657324f79bd97928651e8274",
"assets/assets/icons/git.svg": "f7287ff316e284af16ce082c870c478f",
"assets/assets/icons/github.svg": "4af9ad9d0790abf821d721796ee1fc1a",
"assets/assets/icons/isarDB.svg": "6ea9c3c19f147616ead605ab63e1c2e7",
"assets/assets/icons/linkedin.svg": "9239dc725cfb7370f079b9803087763d",
"assets/assets/icons/mysql.svg": "222fcb5d7151e7e2a54082d5f7bb45ca",
"assets/assets/icons/riverpod.svg": "91c8a2a3a1506b60b3d691b354e90962",
"assets/assets/icons/youtube.svg": "23ce2884a80c0acb238075e3ee03b8b8",
"assets/assets/images/face.jpg": "6cbec108bf430fad6989e6411af9acd0",
"assets/assets/images/mt-fuji.jpeg": "72028de5d77a926884c714244ee5224f",
"assets/assets/images/projects/cinemapedia_1.jpg": "098e0d5beac939f2703d358f381d8861",
"assets/assets/images/projects/cinemapedia_2.jpg": "eac06c43040065dc483a690549780145",
"assets/assets/images/projects/cinemapedia_3.jpg": "a3347e30f8c49b04d0e3dea1dfe5fa11",
"assets/assets/images/projects/cinemapedia_4.jpg": "d4cc81916c586d309debedcdf090640e",
"assets/assets/images/projects/cinemapedia_5.jpg": "6369eb55c5ffdf7371826e890fc25466",
"assets/assets/images/projects/cinemapedia_6.jpg": "a3fc68e15038fddb9833ce7c645ffb04",
"assets/assets/images/projects/cinemapedia_7.jpg": "2c64b35b3cb9095eece45fde7ab07b55",
"assets/assets/images/projects/cinemapedia_8.jpg": "891d9360377b768307f36a7245d9b7cd",
"assets/assets/images/projects/cinemapedia_9.jpg": "28ee37118be4a7ed05663567361e9cad",
"assets/assets/images/projects/cinemapedia_icon.png": "9de826d35d47713de365dd916bd33e47",
"assets/assets/images/projects/ponte_al_dia_1.png": "040e1a3277cc170f9ab219dbe8dc45da",
"assets/assets/images/projects/ponte_al_dia_2.png": "cb38dbdc12d7c249355c44cea5498319",
"assets/assets/images/projects/ponte_al_dia_3.png": "12d19eee1ecfa5d27f448ba013e98bb5",
"assets/assets/images/projects/ponte_al_dia_4.png": "c7104da732f336e0cb68452e84a00827",
"assets/assets/images/projects/ponte_al_dia_5.png": "16b32d63a24a2b07ca25cadefa864297",
"assets/assets/images/projects/ponte_al_dia_6.png": "6ee44e95fe1e8ac2ab7e72a7d7e3f5cd",
"assets/assets/images/projects/ponte_al_dia_7.png": "d9d0a2689d3959b422fd4a74a2a04344",
"assets/assets/images/projects/ponte_al_dia_8.png": "33e7d3bec41f0fa2d19d7084a1fc9931",
"assets/assets/images/projects/ponte_al_dia_icon.png": "b967bd6eddf9317e377695e304c27a38",
"assets/assets/images/projects/teslo_shop_1.jpg": "d725049991131d825729a7aafa6d09b7",
"assets/assets/images/projects/teslo_shop_2.jpg": "1702d0dee1b13bc53c4d817cea3e6842",
"assets/assets/images/projects/teslo_shop_3.jpg": "d87b4a76c5de10f25d6217336a3f030f",
"assets/assets/images/projects/teslo_shop_4.jpg": "4c6800489b23a125a55dc9207d240767",
"assets/assets/images/projects/teslo_shop_5.jpg": "7abb170fadffb5c70be8165f08b8844b",
"assets/assets/images/projects/teslo_shop_6.jpg": "322c7e601d913486fa07081022a7d3f1",
"assets/assets/images/projects/teslo_shop_7.jpg": "e812b616c6a6f283e608af15ccec40a4",
"assets/assets/images/projects/teslo_shop_8.jpg": "e3da0f31016ed44a383a16bf65a0d52d",
"assets/assets/images/projects/teslo_shop_icon.png": "51a8874ff739e68f5e399ba8dc6669ef",
"assets/FontManifest.json": "fb10592ebcd880f833cc3c047820e507",
"assets/fonts/DMSans-Bold.ttf": "7a6c1a2c6196d4d0e617b57adb997b3b",
"assets/fonts/DMSans-Italic.ttf": "d456fd1a58332b02c79e9bda60c4853e",
"assets/fonts/DMSans-Regular.ttf": "74f9bb7405caec741a24db735b2c5733",
"assets/fonts/MaterialIcons-Regular.otf": "a14915c73dbfc38a3001cc66839a5a02",
"assets/NOTICES": "43e96ecc2175a83851ff3f8dadd239e9",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "f47a64603a25ff9f3cf85b673fcd9410",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "0a23dd4c1fb3afb1824f3039c2d4d86c",
"/": "0a23dd4c1fb3afb1824f3039c2d4d86c",
"main.dart.js": "5e2a7416fc5c1452e5384431af0fe0b0",
"manifest.json": "d8fe34f7ae4c072a77b924e01dac8a50",
"version.json": "528590cfb00fc1ca502120db4808bb64"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
