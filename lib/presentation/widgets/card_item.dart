import 'package:flutter/material.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';

class CardItem extends StatelessWidget {

  final int index;

  const CardItem({
    super.key,
    required this.index,
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
            child: _ContentContainer()
          ),

        ],
      ),
    );
  }
}

class _ContentContainer extends StatelessWidget {

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
              'Ponte al día',
              style: TextStyle(color: AppColors.dark, fontSize: 25.0),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
      
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: Image.asset(
              'assets/images/app_icon.png',
              fit: BoxFit.cover,
            ),
          ),
      
          Text(
            'App para buscar películas, agregar favoritos y ver la cartelera actual.',
            style: TextStyle(color: AppColors.dark),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
      
        ]
      ),
    );
  }

}