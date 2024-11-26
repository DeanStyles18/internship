import 'package:flutter/material.dart';
import 'models/aotw.dart' as aotw_models;
import 'artist_carousel.dart'; // Import the CarouselWidget
import 'api_service.dart'; // Import ApiService

class ArtistOfTheWeekPage extends StatefulWidget {
  @override
  _ArtistOfTheWeekPageState createState() => _ArtistOfTheWeekPageState();
}

class _ArtistOfTheWeekPageState extends State<ArtistOfTheWeekPage> {
  final int _pageNo = 1;
  final int _itemsPerPage = 10;
  List<aotw_models.Data> _artists = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchArtists();
  }

  Future<void> _fetchArtists() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final apiService =
          ApiService('https://yourapi.com/api'); // Provide the correct base URL
      final fetchedArtists =
          await apiService.fetchArtistsOfTheWeek(_pageNo, _itemsPerPage);

      setState(() {
        if (fetchedArtists.isEmpty) {
          // Optionally handle empty state
        } else {
          _artists.addAll(fetchedArtists);
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching artists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artist of the Week'),
        backgroundColor: Colors.black, // Set AppBar color
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black, // Background color for the entire page
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Artist of the Week',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              _artists.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : CarouselWidget(artists: _artists),
              SizedBox(height: 16), // Spacing between sections
            ],
          ),
        ),
      ),
    );
  }
}
