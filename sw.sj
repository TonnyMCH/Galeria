const CACHE_NAME = 'galeria-cache-v1';
const assetsToCache = [
    './',
    './index.html',
    './manifest.json',
    './imagenes/imagen1.jpg',
    './imagenes/imagen2.jpg',
    './imagenes/imagen3.jpg',
    './imagenes/imagen4.jpg',
    './imagenes/icono-192x192.png',
    './imagenes/icono-512x512.png'
];

// Instalar el Service Worker y almacenar en caché los archivos
self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(assetsToCache))
            .then(() => self.skipWaiting())
    );
});

// Activar el Service Worker y limpiar cachés antiguas
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.filter(cache => cache !== CACHE_NAME)
                    .map(cache => caches.delete(cache))
            );
        })
    );
});

// Interceptar solicitudes y responder desde la caché
self.addEventListener('fetch', event => {
    event.respondWith(
        caches.match(event.request)
            .then(response => response || fetch(event.request))
    );
});
