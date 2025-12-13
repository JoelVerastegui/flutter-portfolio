final List<Map<String, dynamic>> projectsData = [
  {
    'title': 'Ponte al día',
    'shortDescription': 'Agenda escolar que mantiene los cursos, horario y tareas en un solo lugar.',
    'description': 'Orden y priorización de tareas según fecha de entrega. Personalización avanzada del tema usando rueda de colores, interfaces intuitivas y dinámicas, notificaciones ajustables.',
    'keyPoints': '''
- Aplicación de principios SOLID.
- Uso de patrones MVVM y Clean Architecture.
- Manejo de versiones con Git y Github.
- Almacenamiento local y en caché.
- Enrutamiento avanzado con go_router y shared_preferences.
- Despliegue en Play Store (pruebas cerradas).''',
    'iconPath': 'assets/images/projects/ponte_al_dia_icon.png',
    'assets': [
      'assets/images/projects/ponte_al_dia_1.png',
      'assets/images/projects/ponte_al_dia_2.png',
      'assets/images/projects/ponte_al_dia_3.png',
      'assets/images/projects/ponte_al_dia_4.png',
      'assets/images/projects/ponte_al_dia_5.png',
      'assets/images/projects/ponte_al_dia_6.png',
      'assets/images/projects/ponte_al_dia_7.png',
      'assets/images/projects/ponte_al_dia_8.png',
    ],
    'technologies': [
      'flutter',
      'riverpod',
      'isarDB',
      'git',
      'github',
    ],
    'sourceUrl': '',
    'videoUrl': 'https://www.youtube.com/watch?v=DdlO9qLc9n0',
  },
  {
    'title': 'Cinemapedia',
    'shortDescription': 'Galería de películas, puntuaciones, búsqueda, favoritos.',
    'description': 'Catálogo de películas organizadas en secciones con diseños llamativos y animaciones suaves. Búsqueda de películas por nombre y colección de películas favoritas.',
    'keyPoints': '''
- Uso de patrones MVVM y Clean Architecture.
- Manejo de versiones con Git y Github.
- Conexión con API de TheMovieDB usando dio.
- Ahorro de memoria en caché de películas buscadas.
- Uso de debouncing para evitar sobrecarga de llamadas al API.
- Almacenamiento local de películas favoritas.
- Implementación de reproductor de Youtube.''',
    'iconPath': 'assets/images/projects/cinemapedia_icon.png',
    'assets': [
    ],
    'technologies': [
      'flutter',
      'riverpod',
      'isarDB',
      'youtube',
      'git',
      'github',
    ],
    'sourceUrl': 'https://github.com/JoelVerastegui/cinemapedia/tree/master',
    'videoUrl': '',
  },
  {
    'title': 'Teslo App',
    'shortDescription': 'Gestor de tienda de ropa con autenticación JWT y acceso a cámara.',
    'description': 'Login y registro de usuarios mediante JWT. Listado de productos y formulario de registro con acceso a la cámara y galería de fotos para su almacenamiento en el servidor.',
    'keyPoints': '''
- Uso de patrones MVVM y Clean Architecture.
- Manejo de versiones con Git y Github.
- Ejecución de contenedor Docker con backend y base de datos MySQL.
- Conexión a backend privado mediante REST API usando dio.
- Autenticación JWT con protección de rutas usando go_router.
- Permisos de acceso a la cámara y galería de fotos.''',
    'iconPath': '',
    'assets': [
    ],
    'technologies': [
      'flutter',
      'riverpod',
      'docker',
      'mysql',
      'git',
      'github',
    ],
    'sourceUrl': 'https://github.com/JoelVerastegui/teslo_app/tree/master',
    'videoUrl': '',
  },
];