import 'package:my_portfolio/domain/entities/project.dart';

abstract class ProjectDatasource {

  Future<List<Project>> loadProjects();

}