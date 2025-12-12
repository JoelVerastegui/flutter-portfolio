import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/entities/project.dart';

import 'package:my_portfolio/presentation/widgets/gallery_carousel.dart';
import 'package:my_portfolio/presentation/widgets/project_info.dart';
import 'package:my_portfolio/presentation/providers/project_provider.dart';

class ProjectView extends ConsumerWidget {

  const ProjectView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final project = ref.watch(projectProvider);
    final project = Project(
      title: 'Ponte al día', 
      shortDescription: 'App móvil de agenda escolar.',
      description: 'App de agenda escolar para apuntar y marcar tareas, organizar horario, etc.', 
      keyPoints: '- Uso de Clean Architechture\n- Patrones de diseño\n- Protección de rutas\n- Uso de JWT para autenticación',
      iconPath: 'assets/images/projects/ponte_al_dia_icon.png',
      assets: [
        'https://www.youtube.com/watch?v=2EwrpXUahUY',
        'assets/images/projects/ponte_al_dia_1.png',
        'assets/images/projects/ponte_al_dia_2.png',
        'assets/images/projects/ponte_al_dia_3.png',
        'assets/images/projects/ponte_al_dia_4.png',
        'assets/images/projects/ponte_al_dia_5.png',
        'assets/images/projects/ponte_al_dia_6.png',
        'assets/images/projects/ponte_al_dia_7.png',
        'assets/images/projects/ponte_al_dia_8.png',
      ],
      technologies: [
        Technologic.flutter,
        Technologic.riverpod,
        Technologic.isarDB,
      ],
      sourceUrl: 'https://github.com/JoelVerastegui',
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // if (project == null) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        
        return SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: [
          
              GalleryCarousel(assetsPaths: project.assets, maxHeight: constraints.maxHeight,),
          
              ProjectInfo(
                project: project,
                clearProject: () => ref.invalidate(projectProvider),
              ),
          
            ],
          ),
        );

      },
    );
  }

}