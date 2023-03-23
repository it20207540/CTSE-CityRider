import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:passenger_app/Screens/home_screen.dart';
import 'package:passenger_app/Screens/profile_screen.dart';
import 'package:passenger_app/Screens/search_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.black87,
              hoverColor: Colors.black87,
              gap: 5,
              activeColor: Colors.white,
              iconSize: 30,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black45,
              color: Color(0xFFFCB333),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),

                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person_sharp,
                  text: 'Profile',
                ),

              ],
              selectedIndex: _page,
              onTabChange: (index) {
                setState(() {
                  _page = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}