import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final String currentRoute;
  final Function? onNavigate; 

  BottomNavBarWidget({required this.currentRoute, this.onNavigate});

  final Color customRedColor = Color.fromARGB(255, 173, 36, 27);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(),
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home, 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.phone_android, 1),
          label: 'Short',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.category, 2),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.video_collection, 3),
          label: 'Video',
        ),

        BottomNavigationBarItem(
          icon: _buildIcon(Icons.person, 4),
          label: 'Artists',
        ),
      ],
      onTap: (index) {
        if (onNavigate != null) {
          onNavigate!(); 
        }
        _onItemTapped(context, index);
      },
    );
  }

  int _getSelectedIndex() {
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/artist':
        return 4;
      case '/category':
        return 2;
      case '/video':
        return 3;
      case '/shorts':
        return 1;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 4:
        Navigator.pushNamed(context, '/artist');
        break;
      case 2:
        Navigator.pushNamed(context, '/category');
        break;
      case 3:
        Navigator.pushNamed(context, '/video');
        break;
      case 1:
        Navigator.pushNamed(context, '/shorts');
        break;
    }
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _getSelectedIndex() == index;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? customRedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
