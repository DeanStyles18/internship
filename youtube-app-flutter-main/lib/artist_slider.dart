import 'package:flutter/material.dart';
import 'package:standups/contants/app_colors.dart';
import 'package:standups/contants/app_contants.dart';
import 'api/api_url.dart';
import 'api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:standups/artist_models.dart' as artist_models;
import 'artist_detail.dart'; 

class ArtistSlider extends StatefulWidget {
  @override
  _ArtistSliderState createState() => _ArtistSliderState();
}

class _ArtistSliderState extends State<ArtistSlider> {
  late ApiService apiService;
  List<artist_models.Data> artists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(
        '${ApiUrls.baseURl}artist/get-public-artist?pageNo=1&itemPerPage=20');
    fetchArtists();
  }

  Future<void> fetchArtists() async {
    try {
      final artistData = await apiService.fetchAllArtists100(20);
      setState(() {
        artists = artistData.data ?? [];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching artists: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (artists.isEmpty) {
      return Center(child: Text('No artists found'));
    }

    // Split the artist list into two halves
    // final firstHalf = artists.sublist(0, artists.length ~/ 2);
    // final secondHalf = artists.sublist(artists.length ~/ 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Artists',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    '/artist',
                    arguments: null,
                  );
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 100,
          width: double.infinity,

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArtistDetailsPage(artistId: artists[index].artistId ?? 0,data: artists[index],),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryColor, // Optional: placeholder color
                    child: ClipOval(
                      child: Image.network(
                        artists[index].artistLargeImg ?? '',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              )

                /*Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),color: Colors.black
                ),
                margin:EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArtistDetailsPage(artistId: artists[index].artistId ?? 0,data: artists[index],),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      AppContents.placeHolderImage(imageURl: artists[index].artistLargeImg,height: 150,width: 180,bottomRadius: 0,bottomRightRidus: 0,topRadius: 15,rightRadius: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
                    child: Text(
                      artists[index].artistName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                  )
                      *//*if (!isTextRight) ...
                                [
                                  // Show text on the left
                                  Expanded(
                                    child: Text(
                  artist.artistName ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                ],
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(artist.artistLargeImg ?? ''),
                                ),
                                if (isTextRight) ...[
                                  // Show text on the right
                                  SizedBox(width: 100),
                                  Expanded(
                                    child: Text(
                  artist.artistName ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                                    ),
                                  ),
                                ],*//*
                    ],
                  ),
                ),
              )*/;
            },),
        )
        // First row - Slider moving from left to right
        /*Container(
          height: 150.0, 
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150.0, 
              autoPlay: true,
              autoPlayInterval:
                  Duration(seconds: 3), 
              enlargeCenterPage: true,
              reverse: false,
              viewportFraction: 1.0, 
            ),
            items: firstHalf.map((artist) {
              return _buildArtistItem(artist, true); 
            }).toList(),
          ),
        ),
        // Second row - Slider moving from right to left
        Container(
          height: 150.0,
          child: ListView.builder(
            itemCount: ,
            itemBuilder: (context, index) {
            return _buildArtistItem(artist, false);
          },),
        ),*/
      ],
    );
  }

  Widget _buildArtistItem(artist_models.Data artist, bool isTextRight) {
    return SizedBox(
      height: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArtistDetailsPage(artistId: artist.artistId ?? 0,data: artist,),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(

            children: [
              AppContents.placeHolderImage(imageURl: artist.artistLargeImg,height: 150,width: 180,bottomRadius: 15,bottomRightRidus: 15,topRadius: 15,rightRadius: 15)
              /*if (!isTextRight) ...
              [
                // Show text on the left
                Expanded(
                  child: Text(
                    artist.artistName ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 4),
              ],
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(artist.artistLargeImg ?? ''),
              ),
              if (isTextRight) ...[
                // Show text on the right
                SizedBox(width: 100),
                Expanded(
                  child: Text(
                    artist.artistName ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],*/
            ],
          ),
        ),
      ),
    );
  }
}
