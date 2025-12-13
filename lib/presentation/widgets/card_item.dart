import 'package:flutter/material.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';

class CardItem extends StatelessWidget {

  final Project project;

  const CardItem(this.project, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.blank,
        borderRadius: BorderRadius.circular(14.0),
      ),
      width: 225.0,
      height: 315.0,
      child: Stack(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: FlutterLogo(size: 30.0),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Transform.flip(
              flipY: true,
              child: FlutterLogo(size: 30.0)
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: _ContentContainer(project)
          ),

        ],
      ),
    );
  }
}

class _ContentContainer extends StatelessWidget {

  final Project project;

  const _ContentContainer(this.project);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              project.title,
              style: TextStyle(color: AppColors.dark, fontSize: 25.0),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
      
          Container(
            padding: EdgeInsets.all(25.0),
            width: 150.0,
            height: 150.0,
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: project.iconPath.isNotEmpty
                ? ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(14.0),
                  child: Image.asset(
                    project.iconPath,
                    fit: BoxFit.cover,
                  ),
                )
                : FlutterLogo(),
            ),
          ),
      
          Text(
            project.shortDescription,
            style: TextStyle(color: AppColors.dark),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
      
        ]
      ),
    );
  }

}