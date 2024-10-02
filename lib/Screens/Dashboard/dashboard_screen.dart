// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/Screens/Cart/cart_screen.dart';
import 'package:nature_nook_app/Screens/Category/category_screen.dart';
import 'package:nature_nook_app/Screens/Home Screen/home_screen.dart';
import 'package:nature_nook_app/Screens/User Profile/profile_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/notification_services.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, required this.selectedIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    LocalNotificationService();
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        bool shouldExit =
            await Utils.showConfirmDialog("Exit", 'Do you want to exit?');
        if (shouldExit) {
          exit(0);
        }
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          showSelectedLabels: true,
          unselectedItemColor: NatureColor.colorOutlineBorder,
          selectedItemColor: NatureColor.primary,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
