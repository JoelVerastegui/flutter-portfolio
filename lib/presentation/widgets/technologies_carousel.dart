import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/domain/entities/project.dart';

class TechnologiesCarousel extends StatefulWidget {

  const TechnologiesCarousel({super.key});

  @override
  State<TechnologiesCarousel> createState() => _TechnologiesCarouselState();

}

class _TechnologiesCarouselState extends State<TechnologiesCarousel> {

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
      spacing: 10.0,
      children: [

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Tecnologías', 
            style: textStyle.headlineMedium?.copyWith(color: AppColors.blank)
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