import 'package:my_portfolio/domain/datasources/project_datasource.dart';
import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {

  final ProjectDatasource datasource;

  ProjectRepositoryImpl(this.datasource);

  @override
  Future<List<Project>> loadProjects() {
    return datasource.loadProjects();
  }

}