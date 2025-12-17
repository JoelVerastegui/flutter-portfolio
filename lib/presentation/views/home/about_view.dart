import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallContainer = size.width < 1400;
    
    final containerDecoration = BoxDecoration(
      // color: Colors.black38,
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black38,
          Colors.black45,
          Colors.black38,
        ],
        stops: [ 0.2, 0.5, 0.8 ],
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ AppColors.blank, Color(0xFFCDD1D6) ],
            stops: [ 0.2, 0.7 ],
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1400.0,
          ),
          child: Column(
            spacing: 15.0,
            children: [
                
              SizedBox(
                height: isSmallContainer ? null : 450.0,
                child: Flex(
                  direction: isSmallContainer ? Axis.vertical : Axis.horizontal,
                  spacing: 15.0,
                  children: [
                
                    if(!isSmallContainer)
                    Expanded(
                      child: Container(
                        decoration: containerDecoration,
                        child: _BioContainer(),
                      ),
                    ),
                
                    if (isSmallContainer)
                    Container(
                      decoration: containerDecoration,
                      child: _BioContainer(),
                    ),
                
                    SizedBox(
                      width: isSmallContainer ? null : 525.0,
                      child: Container(
                        decoration: containerDecoration,
                        child: _SkillContainer(),
                      ),
                    ),
                
                  ]
                ),
              ),
                
              Container(
                width: size.width,
                decoration: containerDecoration,
                child: _CarouselContainer(),
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}

class _BioContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final contentAboutMe = '''
Como desarrollador de Flutter, mi pasión reside en crear aplicaciones con un diseño inteligente. Me esfuerzo por crear código que no solo sea funcional, sino también fácil de entender, mantener y adaptar a medida que el proyecto evoluciona. 

Valoro mucho la organización estructurada, el cumplimiento de las mejores prácticas y la implementación de un diseño arquitectónico claro. Me considero una persona autodidacta, impulsado por el deseo de investigar, comprender y solucionar los problemas y retos que surgen en la creación de un proyecto.''';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        spacing: 20.0,
        children: [

          Text(
            '¿Quién soy?', 
            style: textStyle.headlineMedium?.copyWith(color: AppColors.blank)
          ),

          Text(
            contentAboutMe,
            style: textStyle.titleLarge?.copyWith(color: AppColors.blank)
          ),

          Text(
            '"Si no es legible, no es mantenible."', 
            style: textStyle.titleLarge?.copyWith( color: AppColors.blank, fontStyle: FontStyle.italic ),
          ),

        ],
      ),
    );
  }

}

class _SkillContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.0,
        children: [

          Text(
            'Habilidades', 
            style: textStyle.headlineMedium?.copyWith(color: AppColors.blank)
          ),
      
          ClipRRect(
            borderRadius: BorderRadius.circular(130.0),
            child: Image.asset(
              'assets/images/face.jpg',
              width: 130.0,
            ),
          ),
      
          _SkillLevel(
            name: 'Widgets personalizados',
            level: 4,
          ),
      
          _SkillLevel(
            name: 'Código y arquitectura limpia',
            level: 4,
          ),
      
          _SkillLevel(
            name: 'Gestión de versiones y CI/CD',
            level: 3,
          ),
      
          _SkillLevel(
            name: 'Despliegue y contenedores',
            level: 2,
          ),
      
          _SkillLevel(
            name: 'Pruebas',
            level: 2,
          ),
      
        ],
      ),
    );
  }

}

class _SkillLevel extends StatelessWidget {

  final String name;
  final int level;

  const _SkillLevel({
    required this.name,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20.0,
      children: [
    
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 314.0
            ),
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  name,
                  style: textStyle.titleLarge?.copyWith(color: AppColors.blank),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        ),
    
        Row(
          spacing: 2.0,
          children: List.generate(5, (index) {
            return Container(
              width: 25.0,
              height: 15.0,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dark, width: 1.5),
                color: index + 1 <= level
                  ? AppColors.primary
                  : null,
              ),
            );
          },),
        )
    
      ],
    );
  }
}

class _CarouselContainer extends StatefulWidget {

  @override
  State<_CarouselContainer> createState() => _CarouselContainerState();

}

class _CarouselContainerState extends State<_CarouselContainer> {

  final List<String> techs = Technologic.values.map((tech) => tech.name).toList();
  final _scrollController = ScrollController();
  late Timer? timer;
  double _scrollSpeed = 1.0;
  int indexHovered = -1;

  @override
  void initState() {
    super.initState();

    final listWidth = 240 * techs.length;
    
    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_scrollController.hasClients) return;

      final currentScroll = _scrollController.offset;

      if (currentScroll >= listWidth) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(currentScroll + _scrollSpeed);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [

        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Tecnologías', 
              style: textStyle.headlineMedium?.copyWith(color: AppColors.blank)
            ),
          ),
        ),

        SizedBox(
          height: 150.0,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: techs.length * 2,
            itemBuilder: (context, index) {
              final item = techs[index % techs.length];
              final randomAnimation = Random().nextInt(5);
          
              return _IconItem(
                onEnter: () => setState(() {
                  indexHovered = index;
                  _scrollSpeed = 0.0;
                }), 
                onExit: () => setState(() {
                  indexHovered = -1;
                  _scrollSpeed = 1.0;
                }), 
                techName: item, 
                isHovered: indexHovered == index,
                randomAnimation: randomAnimation,
              );
            },
          ),
        ),

      ]
    );
  }

}

class _IconItem extends StatelessWidget {

  final Function() onEnter;
  final Function() onExit;
  final String techName;
  final bool isHovered;
  final int randomAnimation;

  const _IconItem({
    required this.onEnter,
    required this.onExit,
    required this.techName,
    required this.isHovered,
    this.randomAnimation = 0,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      child: MouseRegion(
        onEnter: (_) => onEnter(),
        onExit: (_) => onExit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 20.0,
          children: [

            Container(
              width: 80.0,
              height: 80.0,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: SvgPicture.asset(
                  'assets/icons/$techName.svg',
                  colorFilter: techName == Technologic.github.name
                    ? ColorFilter.mode(AppColors.dark, BlendMode.srcIn)
                    : null,
                )
                .rubberBand(
                  animate: isHovered && randomAnimation == 0,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                )
                .dance(
                  animate: isHovered && randomAnimation == 1,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                )
                .pulse(
                  animate: isHovered && randomAnimation == 2,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                )
                .heartBeat(
                  animate: isHovered && randomAnimation == 3,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                )
                .tada(
                  animate: isHovered && randomAnimation == 4,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ),

            Text(
              techName, 
              style: TextStyle(color: AppColors.blank, fontSize: 18.0),
            )

          ],
        ),
      ),
    );
  }

}