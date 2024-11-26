import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:standups/Categories_page.dart';
import 'package:standups/contants/app_fonts.dart';
import 'home_screen.dart'; 
import 'artist_page.dart';
import 'videos.dart';
import 'shorts_page.dart'; 
import 'splash_screen.dart';
import 'repo/get_di.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Standups7',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: AppFonts.poppinsBold,
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      initialRoute: '/splash',
      key: Get.key,
      routes: {
        '/splash': (context) => SplashScreen(), 
        '/home': (context) => HomeScreen(), 
        '/artist': (context) => ArtistPage(), 
        '/video': (context) => VideoPage(), 
        '/category': (context) => CategoryGridPage(), 
      
        '/shorts': (context) {
         
          final String videoId =
              ModalRoute.of(context)?.settings.arguments as String? ??
                  "22945"; 
          return ShortsDetailPage(
              videoId: videoId);
        },
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Unknown route: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
