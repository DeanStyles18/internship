import 'package:flutter/material.dart';
import 'package:standups/contants/app_colors.dart';
import 'package:standups/navigation_bar.dart';
import 'home_page_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      /*appBar: SearchHeader(
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchToggle: () {
          setState(() {
            _isSearching = !_isSearching;
            if (!_isSearching) {
              _searchController.clear();
            }
          });
        },
        onSubmitted: (query) {
         
        },
      ),*/
      body: SingleChildScrollView(
        child: HomePageContent(),
      ),
      bottomNavigationBar: BottomNavBarWidget(currentRoute: '/home'),
    );
  }
}
