import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  final String currentRoute;

  DrawerWidget({required this.currentRoute});

  // Define the custom red color
  final Color customRedColor = Color.fromARGB(255, 173, 36, 27);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icon.svg',
                    height: 50, 
                  ),
                ),
              ),
            ),

        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentRoute == '/home'
                      ? customRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                child: ListTile(
                  leading: Icon(Icons.home,
                      color:
                          currentRoute == '/home' ? Colors.white : Colors.black,
                      size: 24),
                  title: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 16,
                        color: currentRoute == '/home'
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentRoute == '/artist'
                      ? customRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                child: ListTile(
                  leading: Icon(Icons.person,
                      color: currentRoute == '/artist'
                          ? Colors.white
                          : Colors.black,
                      size: 24),
                  title: Text(
                    'Artist',
                    style: TextStyle(
                        fontSize: 16,
                        color: currentRoute == '/artist'
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/artist');
                  },
                ),
              ),
            ),

   
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentRoute == '/category'
                      ? customRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                child: ListTile(
                  leading: Icon(Icons.category,
                      color: currentRoute == '/category'
                          ? Colors.white
                          : Colors.black,
                      size: 24),
                  title: Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 16,
                        color: currentRoute == '/category'
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/category');
                  },
                ),
              ),
            ),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentRoute == '/video'
                      ? customRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.video_collection,
                      color: currentRoute == '/video'
                          ? Colors.white
                          : Colors.black,
                      size: 24),
                  title: Text(
                    'Video',
                    style: TextStyle(
                        fontSize: 16,
                        color: currentRoute == '/video'
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/video');
                  },
                ),
              ),
            ),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentRoute == '/shorts'
                      ? customRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                child: ListTile(
                  leading: Icon(Icons.phone_android,
                      color: currentRoute == '/shorts'
                          ? Colors.white
                          : Colors.black,
                      size: 24),
                  title: Text(
                    'Shorts',
                    style: TextStyle(
                        fontSize: 16,
                        color: currentRoute == '/shorts'
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/shorts');
                  },
                ),
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
