import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';

class WelcomeView extends StatelessWidget {

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [
                Color(0xFF3C3E35),
                AppColors.dark,
              ],
              stops: [0.1, 0.7],
            ),
          ),
        ),
        
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 370.0,
              minHeight: size.height,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
            
                  Text(
                    'Hola, soy',
                    style: TextStyle(
                      color: AppColors.blank, 
                      fontSize: 20.0,
                    )
                  )
                  .fadeInLeft(
                    delay: const Duration(seconds: 3),
                  ),
              
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Joel Verástegui', 
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 50.0,
                      )
                    )
                    .fadeInLeft(
                      delay: const Duration(seconds: 3),
                    ),
                  ),
            
                  SizedBox(height: 50.0),
                  
                  Center(child: 
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: _AnimatedAvatarContainer()
                    )
                  ),
                  
                  SizedBox(height: 50.0),
                  
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
          ),
        ),

      ],
    );
  }

}

class _AnimatedAvatarContainer extends StatefulWidget {
  @override
  State<_AnimatedAvatarContainer> createState() => _AnimatedAvatarContainerState();
}

class _AnimatedAvatarContainerState extends State<_AnimatedAvatarContainer> {

  BorderRadius borderRadiusAnimation = BorderRadius.circular(20.0);
  bool triggerPulse = false;
  List<Color> colors = [
    Color(0xFF0C9092),
    Color(0xFF1F9C92),
    Color(0xFF32A892),
    Color(0xFF45B492),
    Color(0xFF59C191),
    Color(0xFF6CCD91),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        ...colors.asMap().entries.map((entry) {
          return _AnimatedSquares(
            index: entry.key,
            color: entry.value,
          )
          .pulse(
            animate: triggerPulse,
            duration: const Duration(milliseconds: 200),
            from: 1.0,
            to: 1.1,
            onFinish: (_) => setState(() => triggerPulse = false),
          );
        }).toList().reversed,
  
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Color(0xFFE8EAED),
            borderRadius: borderRadiusAnimation,
          ),
        )
        .zoomIn(
          duration: const Duration(milliseconds: 400),
        )
        .pulse(
          duration: const Duration(milliseconds: 600),
          onFinish: (_) {
            setState(() => borderRadiusAnimation = BorderRadius.circular(5.0));
          }
        )
        .spinPerfect(
          delay: const Duration(milliseconds: 1200),
          curve: Curves.easeOutQuint,
          duration: const Duration(milliseconds: 3000),
        ),

        GestureDetector(
          onTap: triggerPulseAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(190.0),
            child: Image.asset(
              'assets/images/face.jpg',
              width: 190.0,
            ),
          )
          .zoomIn(
            delay: const Duration(milliseconds: 1500),
          ),
        ),

      ],
    );
  }

  Future<void> triggerPulseAnimation() async {
    if (triggerPulse) return;
    setState(() => triggerPulse = true);
  }

}

class _AnimatedSquares extends StatelessWidget {

  final int index;
  final Color color;

  const _AnimatedSquares({
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20.0 * index,
      child: Container(
        width: 20.0 * (index + 10),
        height: 20.0 * (index + 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
      )
      .zoomIn(
        delay: const Duration(milliseconds: 1200),
        duration: const Duration(milliseconds: 1500),
      )
      .spinPerfect(
        curve: Curves.easeOutQuint,
        duration: const Duration(milliseconds: 3000),
      )
      .spinPerfect(
        duration: const Duration(minutes: 5),
        infinite: true
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