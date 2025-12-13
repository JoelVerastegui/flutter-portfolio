import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/presentation/providers/projects_provider.dart';
import 'package:my_portfolio/presentation/widgets/card_item.dart';

class ProjectNavigationBar extends ConsumerWidget {

  const ProjectNavigationBar({ super.key });

  @override
  Widget build(BuildContext context, ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      error: (error, stackTrace) => Center(child: Text('Error al cargar los proyectos. $error'),),
      loading: () => SizedBox(),
      data: (projects) => SizedBox(
        width: double.infinity,
        height: 315.0,
        child: Center(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            itemCount: projects.length,
            separatorBuilder: (_, _) => SizedBox(width: 15.0),
            itemBuilder: (context, index) => _ProjectCard(projects[index], index),
          ),
        ),
      ),
    );
  }

}

class _ProjectCard extends StatefulWidget {

  final Project project;
  final int index;

  const _ProjectCard(this.project, this.index);

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {

  int hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final index = widget.index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoverIndex = index),
      onExit: (_) => setState(() => hoverIndex = -1),
      child: LongPressDraggable<Project>(
        data: project,
        delay: const Duration(milliseconds: 100),
        feedback: Material(color: Colors.transparent, child: CardItem(project)),
        child: CardItem(project)
          .moveTo(
            animate: hoverIndex == index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
            top: 100.0,
          )
      ),
    );
  }
  
}