import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/presentation/providers/project_provider.dart';
import 'package:my_portfolio/presentation/widgets/gallery_carousel.dart';
import 'package:my_portfolio/presentation/widgets/project_info.dart';

class ProjectView extends ConsumerWidget {

  const ProjectView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final project = ref.watch(projectProvider.select((state) => state.project));
    final currentPosition = ref.watch(projectProvider.select((state) => state.currentPosition));
    final isFirstProject = ref.watch(projectProvider.select((state) => state.isFirst));
    final isLastProject = ref.watch(projectProvider.select((state) => state.isLast));
    final projectNotifier = ref.read(projectProvider.notifier);
    final responsiveWidth = 800;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (project == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1020.0,
            ),
            child: Flex(
              direction: constraints.maxWidth <= responsiveWidth ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [

                if (constraints.maxWidth > responsiveWidth)
                Opacity(
                  opacity: isFirstProject ? 0.5 : 1.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 40.0, color: AppColors.blank),
                    onPressed: isFirstProject ? null : projectNotifier.previousProject,
                  ),
                ),
            
                if (project.assets.isNotEmpty)
                GalleryCarousel(assetsPaths: project.assets, maxHeight: constraints.maxHeight, projectIndex: currentPosition),
                
                if (constraints.maxWidth > responsiveWidth)
                Expanded(
                  child: ProjectInfo(
                    project: project,
                    clearProject: () => ref.invalidate(projectProvider),
                  ),
                ),
            
                if (constraints.maxWidth <= responsiveWidth)
                ProjectInfo(
                  project: project,
                  clearProject: () => ref.invalidate(projectProvider),
                ),

                if (constraints.maxWidth > responsiveWidth)
                Opacity(
                  opacity: isLastProject ? 0.5 : 1.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 40.0, color: AppColors.blank),
                    onPressed: isLastProject ? null : projectNotifier.nextProject,
                  ),
                ),
            
              ],
            ),
          ),
        );
      },
    );
  }

}