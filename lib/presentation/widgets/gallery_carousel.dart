import 'dart:async';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';

class GalleryCarousel extends StatefulWidget {

  final List<String> assetsPaths;
  final double maxHeight;

  const GalleryCarousel({
    super.key,
    required this.assetsPaths,
    required this.maxHeight,
  });

  @override
  State<GalleryCarousel> createState() => GalleryCarouselState();
}

class GalleryCarouselState extends State<GalleryCarousel> {

  final scrollController = ScrollController();
  late YoutubePlayerController youtubeController;
  Timer? carouselTimer;
  Timer? continueCarouselTimer;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _galleryCarousel();

    youtubeController = YoutubePlayerController(
      params: YoutubePlayerParams(
        showControls: true,
        mute: true,
        strictRelatedVideos: true,
        origin: Uri.base.origin, // IMPORTANTE EN WEB
      ),
    );

    //TODO: No se debe pasar al siguiente asset hasta que haya finalizado el video si se le dio click a reproducir
    //youtubeController.listen(onData);
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
            child: _AssetViewer(
              youtubeController: youtubeController, 
              assetUrl: widget.assetsPaths[selectedIndex], 
              verifyYoutubeUrl: extractYoutubeId,
            ),
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
                  
                  return _AssetCarouselItem(
                    assetUrl: widget.assetsPaths[index], 
                    isAssetSelected: selectedIndex == index, 
                    selectAsset: () => _selectAsset(index),
                    verifyYoutubeUrl: extractYoutubeId
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

class _AssetViewer extends StatelessWidget {

  final YoutubePlayerController youtubeController;
  final String assetUrl;
  final String Function(String) verifyYoutubeUrl;

  const _AssetViewer({
    required this.youtubeController,
    required this.assetUrl,
    required this.verifyYoutubeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        color: AppColors.dark,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: verifyYoutubeUrl(assetUrl).isNotEmpty
            ? YoutubePlayer(
              controller: youtubeController,
              aspectRatio: 9 / 16,
            )
            : Image.asset(
              assetUrl,
              key: ValueKey<String>('asset:$assetUrl'),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
        )
      )
    );
  }

}

class _AssetCarouselItem extends StatelessWidget {

  final String assetUrl;
  final bool isAssetSelected;
  final Function() selectAsset;
  final String Function(String) verifyYoutubeUrl;

  const _AssetCarouselItem({
    required this.assetUrl, 
    required this.isAssetSelected, 
    required this.selectAsset,
    required this.verifyYoutubeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectAsset,
      child: Container(
        width: 50.0,
        decoration: BoxDecoration(
          border: isAssetSelected
            ? Border.all(color: AppColors.blank, width: 2.0)
            : null
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.dark,
          ),
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: verifyYoutubeUrl(assetUrl).isEmpty 
              ? Image.asset(
                assetUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ) 
              : Placeholder(), //TODO: Agregar la miniatura del video
          ),
        ),
      ),
    );
  }
  
}