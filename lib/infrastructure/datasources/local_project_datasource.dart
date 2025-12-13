import 'package:my_portfolio/domain/datasources/project_datasource.dart';
import 'package:my_portfolio/domain/entities/project.dart';
import 'package:my_portfolio/infrastructure/mappers/project_mapper.dart';
import 'package:my_portfolio/shared/data/projects_data.dart';

class LocalProjectDatasource extends ProjectDatasource {

  @override
  Future<List<Project>> loadProjects() async {
     final projects = projectsData.map((project) => ProjectMapper.projectToEntity(project)).toList();

     return projects;
  }

}