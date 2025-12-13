import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:my_portfolio/presentation/providers/project_provider.dart';
import 'package:my_portfolio/presentation/views/home/formation_view.dart';
import 'package:my_portfolio/presentation/views/home/projects_view.dart';
import 'package:my_portfolio/presentation/views/home/welcome_view.dart';
import 'package:my_portfolio/presentation/widgets/project_navigation_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  final ScrollController scrollController = ScrollController();
  final welcomeKey = GlobalKey();
  final projectsKey = GlobalKey();
  final formationKey = GlobalKey();
  bool isButtonUpVisible = false;
  bool areCardsVisible = false;
  double projectsTopLimit = 0.0;
  double projectsBottomLimit = 0.0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels > 300) {
        if (!isButtonUpVisible) setState(() => isButtonUpVisible = true);
      } else {
        if (isButtonUpVisible) setState(() => isButtonUpVisible = false);
      }

      if (projectsTopLimit > 0 && projectsBottomLimit > 0) {
        if (scrollController.position.pixels < (projectsBottomLimit - 200)) {
          if (areCardsVisible) setState(() => areCardsVisible = false);
        }
        if (scrollController.position.pixels > (projectsTopLimit - 200)) {
          if (!areCardsVisible) setState(() => areCardsVisible = true);
        }
        if (scrollController.position.pixels > (projectsBottomLimit - 200)) {
          if (areCardsVisible) setState(() => areCardsVisible = false);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateLimits();
    });

  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProject = ref.watch(projectProvider.select((state) => state.project));
    final isPhoneDevice = MediaQuery.of(context).size.shortestSide < 600;

    return Scaffold(
      floatingActionButton: isButtonUpVisible 
        ? FloatingActionButton(
          onPressed: _scrollToTop, 
          tooltip: 'Volver a Inicio',
          shape: CircleBorder(),
          backgroundColor: AppColors.dark,
          foregroundColor: AppColors.blank,
          child: Icon(Icons.keyboard_arrow_up, size: 40.0),
        )
        .zoomIn() 
        : null,
      body: Stack(
        children: [
      
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                
                WelcomeView(key: welcomeKey),
                      
                ProjectsView(key: projectsKey),
                      
                FormationView(key: formationKey),
            
              ]
            ),
          ),
      
          Positioned(
            left: 0,
            right: 0,
            bottom: -315.0,
            child: ProjectNavigationBar()
              .moveTo(
                animate: areCardsVisible,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                top: isPhoneDevice
                ? 315.0
                : 215.0,
              )
              .moveTo(
                animate: selectedProject != null,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                bottom: isPhoneDevice
                ? 315.0
                : 215.0,
              ),
          ),
          
        ]
      )
    );
  }

  void _scrollToTop() {
    Scrollable.ensureVisible(
      welcomeKey.currentContext!,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
    );
  }

  void _updateLimits() {
    final renderBoxTop = projectsKey.currentContext?.findRenderObject() as RenderBox?;
    final renderBoxBottom = formationKey.currentContext?.findRenderObject() as RenderBox?;
    final positionTop = renderBoxTop?.localToGlobal(Offset.zero);
    final positionBottom = renderBoxBottom?.localToGlobal(Offset.zero);

    if (positionTop != null && positionBottom != null) {
      setState(() {
        projectsTopLimit = positionTop.dy;
        projectsBottomLimit = positionBottom.dy;
      });
    }
  }

}