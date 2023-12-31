import 'package:flutter/material.dart';
import 'package:welf_price/View/cryptList.dart';

import 'anotherPage.dart';
import 'home.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Home(),
    CryptList(),
  ];

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    // double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white.withOpacity(0.2),
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              setState(() {
                _currentIndex = value;
              });
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/1.1.png',
                    height: myHeight * 0.03,
                    color: Colors.white,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/1.2.png',
                    height: myHeight * 0.03,
                    color: Colors.white,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/2.1.png',
                    height: myHeight * 0.03,
                    color: Colors.white,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/icons/2.2.png',
                    height: myHeight * 0.03,
                    color: Colors.white,
                  )),
            ]),
      ),
    );
  }
}
