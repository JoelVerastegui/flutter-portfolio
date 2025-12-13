import 'package:my_portfolio/domain/entities/project.dart';

abstract class ProjectRepository {

  Future<List<Project>> loadProjects();

}