import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:standups/models/aotw.dart' as aotw_models;

import 'artist_detail.dart';

class CarouselWidget extends StatefulWidget {
  final List<aotw_models.Data>? artists;

  CarouselWidget({this.artists});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;
  final int _autoSlideDuration = 3;
  bool _isAutoSliding = true;
  int _currentIndex = 0;
// Always show the artist name

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.artists != null
          ? widget.artists!.length
          : 0, // Start in the middle
    );
    _startAutoSlide();
  }

  void _startAutoSlide() {
    if (_isAutoSliding) {
      Future.delayed(Duration(seconds: _autoSlideDuration), () {
        if (_pageController.hasClients) {
          _pageController.nextPage(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          _startAutoSlide();
        }
      });
    }
  }

  @override
  void dispose() {
    _isAutoSliding = false;
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.artists == null || widget.artists!.isEmpty) {
      return Center(child: Text('No artists available'));
    }

    final artists = widget.artists!;
    final itemCount = artists.length;
    final List<aotw_models.Data> carouselItems = [
      ...artists,
      ...artists,
    ];

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: carouselItems.length,
            onPageChanged: (index) {
              if (index == carouselItems.length - 1) {
                // Reset to the start of the carousel
                _pageController.jumpToPage(itemCount);
              } else {
                setState(() {
                  _currentIndex = index % itemCount;
                });
              }
            },
            itemBuilder: (context, index) {
              final artist = carouselItems[index % itemCount];
              return GestureDetector(
                onTap: () {
                  // Navigate to the artist detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtistDetailsPage(
                        artistId: artist.artistId ?? 0,
                        data: null,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: artist.largeImg ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            margin: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(16)),
                            ),
                            child: Text(
                              '${(index % itemCount) + 1}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24), // Larger font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 12,
            right: 12,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: Text(
                  widget.artists![_currentIndex].artistName ?? 'Unknown Artist',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
