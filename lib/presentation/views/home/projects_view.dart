import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/presentation/providers/project_provider.dart';
import 'package:my_portfolio/presentation/views/home/project_view.dart';

class ProjectsView extends ConsumerWidget {

  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return DragTarget<Project>(
      builder: (context, candidateData, rejectedData) {
        final proyecto = candidateData.firstOrNull;

        return _CardTable(proyecto: proyecto);
      },
      onAcceptWithDetails: (details) {
        ref.read(projectProvider.notifier).selectProject(details.data);
      },
    );
  }

}

class _CardTable extends ConsumerWidget {

  final Project? proyecto;

  const _CardTable({
    this.proyecto,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedProject = ref.watch(projectProvider.select((state) => state.project));
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          focalRadius: 100.0,
          colors: [
            Color(0xFF1E6B43),
            Color(0xFF0F4F2F),
            Color(0xFF052A18),
          ],
          stops: [0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blank, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),

          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: selectedProject != null
              ? Padding(
                padding: EdgeInsets.all(20.0),
                child: ProjectView()
              )
              : Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20.0,
                    children: [
            
                      if (proyecto != null)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 300.0,
                          maxHeight: 300.0,
                        ),
                        child: Stack(
                          children: [
                        
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox.expand(
                                child: DottedBorder(
                                  options: OvalDottedBorderOptions(
                                    dashPattern: [10, 5],
                                    strokeWidth: 2,
                                    color: AppColors.blank,
                                    padding: EdgeInsets.all(16),
                                  ),
                                  child: SizedBox(),
                                )
                                .spinPerfect(infinite: true),
                              ),
                            ),
                        
                            Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  proyecto!.title,
                                  style: TextStyle(
                                    color: AppColors.blank,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                            )
                        
                          ],
                        ),
                      ),
                  
                      if (proyecto == null)
                      Text(
                        'Mira mis proyectos', 
                        style: TextStyle(
                          color: AppColors.blank,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )
                      ),
                  
                      if (proyecto == null)
                      Text(
                        'Selecciona una carta y arrástrala aquí.', 
                        style: TextStyle(
                          color: AppColors.blank,
                          fontSize: 16.0,
                        )
                      ),
                  
                    ],
                  ),
                ),
            ),
          ),

        ],
      ),
    );
  }

}