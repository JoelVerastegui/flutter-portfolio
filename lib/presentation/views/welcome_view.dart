import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/presentation/widgets/welcome_avatar.dart';

class WelcomeView extends StatelessWidget {

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final bgGradient = BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [ Color(0xFF3C3E35), AppColors.dark ],
        stops: [0.1, 0.7],
      ),
    );

    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      decoration: bgGradient,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 370.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                
            Text(
              'Hola, soy',
              style: textStyle.titleLarge?.copyWith(color: AppColors.blank),
            )
            .fadeInLeft(
              delay: const Duration(seconds: 3),
            ),
        
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Joel Verástegui', 
                style: textStyle.displayLarge?.copyWith(color: AppColors.primary),
              )
              .fadeInLeft(
                delay: const Duration(seconds: 3),
              ),
            ),
                
            Flexible(
              child: WelcomeAvatar(),
            ),
            
            Text(
              'Soy desarrollador Flutter y me fascina crear apps móviles que aporten valor a las personas.',
              style: TextStyle(
                color: AppColors.blank, 
                fontSize: 20.0,
              )
            )
            .fadeInLeft(
              delay: const Duration(seconds: 3),
            ),
            
            SizedBox(height: 20.0),
            
            _SocialButtons()
            
          ],
        ),
      ),
    );
  }

}

class _SocialButtons extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15.0,
      children: [

        IconButton(
          onPressed: () => launch(
            'https://www.linkedin.com/in/joelverastegui/',
          ),
          tooltip: 'https://www.linkedin.com/in/joelverastegui/',
          icon: SvgPicture.asset(
            'assets/icons/linkedin.svg',
            width: 30.0,
            height: 30.0,
          ),
        )
        .zoomIn(
          delay: const Duration(seconds: 3),
        ),

        IconButton(
          onPressed: () => launch(
            'https://github.com/JoelVerastegui',
          ),
          tooltip: 'https://github.com/JoelVerastegui',
          icon: SvgPicture.asset(
            'assets/icons/github.svg',
            width: 30.0,
            height: 30.0,
          ),
        )
        .zoomIn(
          delay: const Duration(seconds: 3),
        ),

      ],
    );
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

}