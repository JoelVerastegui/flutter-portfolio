import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/presentation/providers/project_provider.dart';
import 'package:my_portfolio/presentation/views/project_view.dart';

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
    final bgGradient = BoxDecoration(
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
    );

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(20.0),
      decoration: bgGradient,
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blank, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: selectedProject != null
              ? Padding(
                padding: EdgeInsets.all(20.0),
                child: ProjectView()
              )
              : _SelectedCardIndicator(proyecto),
          ),
        ),
      ),
    );
  }

}

class _SelectedCardIndicator extends StatelessWidget {

  final Project? project;

  const _SelectedCardIndicator(this.project);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    if (project == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.0,
        children: [

          Text(
            'Mira mis proyectos', 
            style: textStyle.headlineLarge?.copyWith(color: AppColors.blank, fontWeight: FontWeight.bold),
          ),
      
          Text(
            'Selecciona una carta y arrástrala aquí.', 
            style: textStyle.titleMedium?.copyWith(color: AppColors.blank)
          ),
      
        ],
      );
    }

    return Container(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300.0,
          maxHeight: 300.0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
        
            SizedBox.expand(
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
        
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                project!.title,
                style: textStyle.headlineMedium?.copyWith(color: AppColors.blank)
              ),
            )
        
          ],
        ),
      ),
    );
  }

}