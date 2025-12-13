import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectInfo extends StatelessWidget {

  final Project project;
  final Function()? clearProject;

  const ProjectInfo({
    super.key,
    required this.project,
    this.clearProject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [
    
        _ProjectIconTitle(project: project),
    
        Text(
          project.shortDescription,
          style: TextStyle(color: AppColors.blank, fontSize: 16.0),
        ),
    
        if (project.description.isNotEmpty)
        Text(
          project.description,
          style: TextStyle(color: AppColors.blank, fontSize: 16.0),
        ),
    
        SizedBox(height: 5.0),
    
        Text(
          'Tecnologías usadas',
          style: TextStyle(color: AppColors.blank, fontSize: 20.0),
        ),
    
        _TechnologiesViewer(project.technologies),
    
        if (project.keyPoints.isNotEmpty)
        ...<Widget>[
          SizedBox(height: 5.0),
    
          Text(
            'Puntos clave',
            style: TextStyle(color: AppColors.blank, fontSize: 20.0),
          ),
    
          Text(
            project.keyPoints,
            style: TextStyle(color: AppColors.blank, fontSize: 16.0),
          ),
        ],
    
        if (project.sourceUrl.isNotEmpty || project.videoUrl.isNotEmpty)
        ...<Widget>[
          SizedBox(height: 5.0),

          _ExternalButtons(
            sourceUrl: project.sourceUrl,
            videoUrl: project.videoUrl,
          ),
        ],
    
        TextButton.icon(
          onPressed: clearProject, 
          icon: Icon(Icons.style, color: AppColors.blank, size: 20.0),
          label: Text(
            'Ver más proyectos',
            style: TextStyle(color: AppColors.blank, fontSize: 20.0)
          )
        ),
    
      ],
    );
  }

}

class _ProjectIconTitle extends StatelessWidget {

  final Project project;

  const _ProjectIconTitle({
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 7.0,
      children: [
    
        if (project.iconPath.isNotEmpty)
        ClipRRect(
          borderRadius: BorderRadius.circular(5.6),
          child: Image.asset(
            project.iconPath,
            fit: BoxFit.cover,
            height: 40.0,
          ),
        ),

        if (project.iconPath.isEmpty)
        FlutterLogo(size: 40.0),
    
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              project.title,
              style: TextStyle(color: AppColors.blank, fontSize: 30.0),
            ),
          ),
        ),
    
      ]
    );
  }

}

class _TechnologiesViewer extends StatelessWidget {

  final List<Technologic> technologies;

  const _TechnologiesViewer(this.technologies);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15.0,
      runSpacing: 15.0,
      children: technologies.map((technologic) {

        final technologicName = technologic.name;
      
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 5.0,
          children: [
    
            if (technologicName == Technologic.flutter.name)
            FlutterLogo(size: 20.0),
    
            if (technologicName != Technologic.flutter.name)
            SvgPicture.asset(
              'assets/icons/$technologicName.svg',
              errorBuilder: (context, error, stackTrace) => FlutterLogo(size: 20.0),
              width: 20.0,
              height: 20.0,
              semanticsLabel: '$technologicName logo icon',
            ),
    
            Text(
              technologicName,
              style: TextStyle(color: AppColors.blank, fontSize: 8.0),
            ),
    
          ],
        );

      }).toList(),
    );
  }

}

class _ExternalButtons extends StatelessWidget {
  
  final String sourceUrl;
  final String videoUrl;

  const _ExternalButtons({
    this.sourceUrl = '',
    this.videoUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.0,
      children: [

        if (sourceUrl.isNotEmpty)
        FilledButton.icon(
          onPressed: () => _launch(sourceUrl), 
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.dark),
          ),
          icon: SvgPicture.asset(
            'assets/icons/github.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Text('Código fuente', style: TextStyle(color: AppColors.blank)),
        ),

        if (videoUrl.isNotEmpty)
        FilledButton.icon(
          onPressed: () => _launch(videoUrl), 
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.blank),
          ),
          icon: SvgPicture.asset(
            'assets/icons/youtube.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Text('Ver demo', style: TextStyle(color: AppColors.dark)),
        ),

      ],
    );
  }
  
  Future<void> _launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

}