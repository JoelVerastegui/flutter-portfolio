import 'dart:async';
import 'package:flutter/material.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';

class GalleryCarousel extends StatefulWidget {

  final List<String> assetsPaths;
  final double maxHeight;
  final int projectIndex;

  const GalleryCarousel({
    super.key,
    required this.assetsPaths,
    required this.maxHeight,
    this.projectIndex = -1,
  });

  @override
  State<GalleryCarousel> createState() => GalleryCarouselState();
  
}

class GalleryCarouselState extends State<GalleryCarousel> {

  final scrollController = ScrollController();
  Timer? carouselTimer;
  Timer? continueCarouselTimer;
  int selectedIndex = 0;
  Map<int, List<String>> precachedImages = {};

  @override
  void initState() {
    super.initState();

    _resumeCarousel();
  }

  @override
  void didUpdateWidget(covariant GalleryCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.projectIndex != widget.projectIndex) {
      carouselTimer?.cancel();

      continueCarouselTimer?.cancel();

      if (!precachedImages.containsKey(widget.projectIndex)) {
        for (final assetPath in widget.assetsPaths) {
          precacheImage(AssetImage(assetPath), context);
        }

        precachedImages[widget.projectIndex] = widget.assetsPaths;
      }

      setState(() => selectedIndex = 0);

      _ensureItemIsVisible();

      _resumeCarousel();
    }
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
              assetUrl: widget.assetsPaths[selectedIndex], 
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

    _ensureItemIsVisible();
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

  void _resumeCarousel() {
    if (widget.assetsPaths.isEmpty) return;

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
      _resumeCarousel();
    });
  }

}

class _AssetViewer extends StatelessWidget {

  final String assetUrl;

  const _AssetViewer({
    required this.assetUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        color: AppColors.dark,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Image(
            image: AssetImage(assetUrl),
            key: ValueKey<String>('asset:$assetUrl'),
            fit: BoxFit.cover,
            gaplessPlayback: true,
            filterQuality: FilterQuality.high,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return Center(child: CircularProgressIndicator(color: AppColors.blank));
              }

              return child;
            },
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

  const _AssetCarouselItem({
    required this.assetUrl, 
    required this.isAssetSelected, 
    required this.selectAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectAsset,
      child: Container(
        width: 50.0,
        decoration: BoxDecoration(
          color: AppColors.dark,
          border: isAssetSelected
            ? Border.all(color: AppColors.blank, width: 2.0)
            : null
        ),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.asset(
            assetUrl,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return Center(child: CircularProgressIndicator(color: AppColors.blank));
              }
              
              return child;
            },
          ),
        ),
      ),
    );
  }
  
}