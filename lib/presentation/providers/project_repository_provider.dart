import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/domain/repositories/project_repository.dart';
import 'package:my_portfolio/infrastructure/datasources/local_project_datasource.dart';
import 'package:my_portfolio/infrastructure/repositories/project_repository_impl.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(LocalProjectDatasource());
});