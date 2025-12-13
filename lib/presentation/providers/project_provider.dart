import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/presentation/providers/projects_provider.dart';

final projectProvider = StateNotifierProvider.autoDispose<ProjectNotifier, ProjectState>((ref) {
  final asyncProjects = ref.watch(projectsProvider);

  final List<Project> projects = asyncProjects.maybeWhen(
    data: (listOfP) => listOfP,
    orElse: () => [],
  );

  return ProjectNotifier(projects);
});

class ProjectNotifier extends StateNotifier<ProjectState> {

  final List<Project> projects;

  ProjectNotifier(this.projects): super(ProjectState());

  void selectProject(Project project) {
    final currentPos = projects.indexWhere((item) => item == project);

    state = state.copyWith(
      project: project,
      currentPosition: currentPos,
    );

    _updatePosition();
  }

  void previousProject() {
    final currentPos = state.currentPosition;

    if (currentPos == -1 || currentPos == 0) return;

    state = state.copyWith(
      project: projects[currentPos - 1],
      currentPosition: currentPos - 1,
    );

    _updatePosition();
  }

  void nextProject() {
    final currentPos = state.currentPosition;

    if (currentPos == -1 || currentPos == (projects.length - 1)) return;

    state = state.copyWith(
      project: projects[currentPos + 1],
      currentPosition: currentPos + 1,
    );

    _updatePosition();
  }

  void _updatePosition() {
    state = state.copyWith(
      isFirst: state.currentPosition == 0,
      isLast: state.currentPosition == (projects.length - 1),
    );
  }
  
}

class ProjectState {

  final Project? project;
  final int currentPosition;
  final bool isFirst;
  final bool isLast;

  const ProjectState({
    this.project,
    this.currentPosition = -1,
    this.isFirst = false,
    this.isLast = false,
  });

  ProjectState copyWith({
    Project? project,
    int? currentPosition,
    bool? isFirst,
    bool? isLast,
  }) => ProjectState(
    project: project ?? this.project,
    currentPosition: currentPosition ?? this.currentPosition,
    isFirst: isFirst ?? this.isFirst,
    isLast: isLast ?? this.isLast,
  );

}