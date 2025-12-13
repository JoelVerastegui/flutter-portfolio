import 'package:equatable/equatable.dart';

enum Technologic { flutter, riverpod, isarDB, dart, docker, git, github, mysql, youtube }

class Project extends Equatable {

  final String title;
  final String shortDescription;
  final String description;
  final String keyPoints;
  final String iconPath;
  final List<String> assets;
  final List<Technologic> technologies;
  final String sourceUrl;
  final String videoUrl;

  const Project({
    required this.title,
    required this.shortDescription,
    this.description = '',
    this.keyPoints = '',
    required this.iconPath,
    this.assets = const [],
    this.technologies = const [], 
    this.sourceUrl = '',
    this.videoUrl = '',
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
    String? videoUrl,
  }) => Project(
    title: title ?? this.title,
    shortDescription: shortDescription ?? this.shortDescription,
    description: description ?? this.description,
    keyPoints: keyPoints ?? this.keyPoints,
    iconPath: iconPath ?? this.iconPath,
    assets: assets ?? this.assets,
    technologies: technologies ?? this.technologies,
    sourceUrl: sourceUrl ?? this.sourceUrl,
    videoUrl: videoUrl ?? this.videoUrl,
  );
  
  @override
  List<Object?> get props => [ title, shortDescription, description, keyPoints, iconPath, assets, technologies, sourceUrl, videoUrl ];

}