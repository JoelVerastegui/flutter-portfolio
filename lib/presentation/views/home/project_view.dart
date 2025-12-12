import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/config/constants/app_colors.dart';
// import 'package:my_portfolio/presentation/providers/project_provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProjectView extends ConsumerWidget {

  const ProjectView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final project = ref.watch(projectProvider);

    final sampleImages = [
      'https://www.youtube.com/watch?v=2EwrpXUahUY',
      'assets/images/ponte_al_dia/Screen_1.png',
      'assets/images/ponte_al_dia/Screen_2.png',
      'assets/images/ponte_al_dia/Screen_3.png',
      'assets/images/ponte_al_dia/Screen_4.png',
      'assets/images/ponte_al_dia/Screen_5.png',
      'assets/images/ponte_al_dia/Screen_6.png',
      'assets/images/ponte_al_dia/Screen_7.png',
      'assets/images/ponte_al_dia/Screen_8.png',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        
        return SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: [
          
              _GallerySection(assetsPaths: sampleImages, maxHeight: constraints.maxHeight,),
          
              Container(
                width: 300.0,
                height: 300.0,
                color: Colors.lightGreen,
                child: Center(
                  child: Text('2', style: TextStyle(fontSize: 40.0))
                ),
              ),
          
            ],
          ),
        );

      },
    );
  }

}

class _GallerySection extends StatefulWidget {

  final List<String> assetsPaths;
  final double maxHeight;

  const _GallerySection({
    required this.assetsPaths,
    required this.maxHeight,
  });

  @override
  State<_GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<_GallerySection> {

  final scrollController = ScrollController();
  late YoutubePlayerController youtubeController;
  late List<GlobalKey> galleryKeys;
  Timer? carouselTimer;
  Timer? continueCarouselTimer;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    galleryKeys = widget.assetsPaths.map((_) => GlobalKey()).toList();

    _galleryCarousel();

    youtubeController = YoutubePlayerController(
      params: YoutubePlayerParams(
        showControls: true,
        mute: true,
        strictRelatedVideos: true,
        //TODO: USAR URL DEL HOST
        origin: Uri.base.origin, // IMPORTANTE EN WEB
      ),
    );
  }

  @override
  void dispose() {
    carouselTimer?.cancel();
    continueCarouselTimer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assetsPaths.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
      
          Container(
            height: widget.maxHeight * 0.8,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black54,
              border: Border.all(color: AppColors.blank, width: 2.0,)
            ),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                color: AppColors.dark,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: extractYoutubeId(widget.assetsPaths[selectedIndex]).isNotEmpty
                  ? YoutubePlayer(
                    controller: youtubeController,
                    aspectRatio: 16 / 9,
                  )
                  : Image.asset(
                    widget.assetsPaths[selectedIndex],
                    key: ValueKey<String>('asset:${widget.assetsPaths[selectedIndex]}'),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                )
              )
            )
          ),
      
          SizedBox(
            height: 100.0,
            child: Scrollbar(
              controller: scrollController,
              child: ListView.separated(
                controller: scrollController,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.assetsPaths.length,
                separatorBuilder: (_, _) => SizedBox(width: 10.0,),
                itemBuilder: (context, index) {
                  
                  return GestureDetector(
                    onTap: () => _selectAsset(index),
                    child: Container(
                      key: galleryKeys[index],
                      width: 50.0,
                      decoration: BoxDecoration(
                        border: selectedIndex == index
                          ? Border.all(color: AppColors.blank, width: 2.0)
                          : null
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.dark,
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: extractYoutubeId(widget.assetsPaths[index]).isEmpty 
                          ? Image.asset(
                            widget.assetsPaths[index],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          ) : Placeholder(),
                        ),
                      ),
                    ),
                  );
              
                },
              ),
            ),
          ),
      
        ]
      ),
    );
  }

  void _nextAsset() {
    setState(() {
      selectedIndex = (selectedIndex + 1) % widget.assetsPaths.length;
    });

    _updateYoutubeController();
    _ensureItemIsVisible();
  }

  void _updateYoutubeController() {
    final ytId = extractYoutubeId(widget.assetsPaths[selectedIndex]);

    if (ytId.isEmpty) return;

    print('Mi link id es: $ytId');

    youtubeController.loadVideoById(videoId: ytId);
  }

  String extractYoutubeId(String url) {
    if (url.contains('youtu.be/')) {
      return url.split('youtu.be/')[1].split('?').first;
    }

    if (url.contains('youtube.com/watch')) {
      return Uri.parse(url).queryParameters['v'] ?? '';
    }

    return '';
  }

  void _ensureItemIsVisible() {
    final isLastItem = selectedIndex == widget.assetsPaths.length - 1;
    final double itemStart = selectedIndex * 60;
    final double itemEnd = itemStart + (isLastItem ? 50 : 60);

    final double viewportStart = scrollController.offset;
    final double viewportEnd = viewportStart + scrollController.position.viewportDimension;

    if (itemStart < viewportStart || itemEnd > viewportEnd) {
      scrollController.animateTo(
        itemStart,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _galleryCarousel() {
    carouselTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _nextAsset();
    });
  }

  void _selectAsset(int index) {
    carouselTimer?.cancel();
    continueCarouselTimer?.cancel();

    setState(() => selectedIndex = index);

    continueCarouselTimer = Timer(const Duration(seconds: 10), () {
      _nextAsset();
      _galleryCarousel();
    });
  }

}