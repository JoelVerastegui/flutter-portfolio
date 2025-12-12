enum Technologic { flutter, riverpod, isarDB }

class Project {

  final String title;
  final String shortDescription;
  final String description;
  final String keyPoints;
  final String iconPath;
  final List<String> assets;
  final List<Technologic> technologies;
  final String sourceUrl;

  const Project({
    required this.title,
    required this.shortDescription,
    this.description = '',
    this.keyPoints = '',
    required this.iconPath,
    this.assets = const [],
    this.technologies = const [], 
    this.sourceUrl = '',
  });

  Project copyWith({
    String? title,
    String? shortDescription,
    String? description,
    String? keyPoints,
    String? iconPath,
    List<String>? assets,
    List<Technologic>? technologies,
    String? sourceUrl,
  }) => Project(
    title: title ?? this.title,
    shortDescription: shortDescription ?? this.shortDescription,
    description: description ?? this.description,
    keyPoints: keyPoints ?? this.keyPoints,
    iconPath: iconPath ?? this.iconPath,
    assets: assets ?? this.assets,
    technologies: technologies ?? this.technologies,
    sourceUrl: sourceUrl ?? this.sourceUrl,
  );

}