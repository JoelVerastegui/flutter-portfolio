import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/presentation/providers/project_repository_provider.dart';

final projectsProvider = FutureProvider<List<Project>>((ref) {
  final projects = ref.watch(projectRepositoryProvider);

  return projects.loadProjects();
});