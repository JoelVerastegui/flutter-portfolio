import 'package:my_portfolio/domain/entities/project.dart';

class ProjectMapper {

  static Project projectToEntity(Map<String, dynamic> data) => Project(
    title: data['title'] ?? '',
    shortDescription: data['shortDescription'] ?? '',
    description: data['description'] ?? '',
    keyPoints: data['keyPoints'] ?? '',
    iconPath: data['iconPath'] ?? '',
    assets: List<String>.from(data['assets'].map((a) => a)),
    technologies: _filterByTechnologic(List<String>.from(data['technologies'].map((t) => t))),
    sourceUrl: data['sourceUrl'] ?? '',
    videoUrl: data['videoUrl'] ?? '',
  );

}

List<Technologic> _filterByTechnologic(List<String> techs) {
  final List<Technologic> technologies = [];

  for (final tech in techs) {
    final index = Technologic.values.indexWhere((e) => e.name == tech);
    
    if (index != -1) {
      technologies.add(Technologic.values.byName(tech));
    }
  }

  return technologies;
}