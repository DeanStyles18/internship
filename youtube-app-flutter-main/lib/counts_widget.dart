import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/api_url.dart';
import 'models/shorts_stats.dart' as shorts;

class CountsWidget extends StatefulWidget {
  final String videoLink;

  const CountsWidget({
    Key? key,
    required this.videoLink,
  }) : super(key: key);

  @override
  _CountsWidgetState createState() => _CountsWidgetState();
}

class _CountsWidgetState extends State<CountsWidget> {
  late Future<shorts.Data> futureStats;

  @override
  void initState() {
    super.initState();
  
    futureStats = fetchVideoStats(widget.videoLink);
  }

  
  Future<shorts.Data> fetchVideoStats(String videoLink) async {
    print('${ApiUrls.baseURl}playlist/get-video-statistics?video_link=9n5YxUZFZVo');
    final response = await http.get(Uri.parse(
        '${ApiUrls.baseURl}playlist/get-video-statistics?video_link=$videoLink'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return shorts.Data.fromJson(
          jsonResponse['data']); 
    } else {
      throw Exception('Failed to load video statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<shorts.Data>(
      future: futureStats,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
        
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
      
          return Center(
            child: Text('', style: TextStyle(color: Colors.white)),
          );
        } else if (snapshot.hasData) {
       
          final stats = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                _buildStatColumn(
                  icon: Icons.thumb_up_alt_outlined,
                  count: '${stats.youtubeLikesCount}',
                ),
                SizedBox(height: 5),
                _buildStatColumn(
                  icon: Icons.comment_outlined,
                  count: '${stats.youtubeCommentCount}',
                ),
                SizedBox(height: 5),
                _buildStatColumn(
                  icon: Icons.visibility_outlined,
                  count: '${stats.youtubeViewsCount}',
                ),
              ],
            ),
          );
        } else {
         
          return Center(
            child: Text('No data available',
                style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }

  Widget _buildStatColumn({required IconData icon, required String count}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.3),
          child: IconButton(
            icon: Icon(icon, color: Colors.red),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 1),
        Text(count, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
