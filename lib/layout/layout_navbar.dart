import 'package:flutter/material.dart';
import 'package:product_organizer/base/constant.dart';
import 'package:product_organizer/pages/demand_page.dart';
import 'package:product_organizer/pages/home_page.dart';
import 'package:product_organizer/pages/stock_page.dart';

class LayoutNavbar extends StatefulWidget {
  const LayoutNavbar({this.index, Key? key}) : super(key: key);

  final int? index;

  @override
  State<LayoutNavbar> createState() => _LayoutNavbarState();
}

class _LayoutNavbarState extends State<LayoutNavbar> {
  late int _selectedPage;

  late final List<Widget> _pages = <Widget> [
    const HomePage(),
    const StockPage(),
    const DemandPage(),
  ];

  @override
  void initState() {
    _selectedPage = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        elevation: 0,
        iconSize: 29,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFF6340AD),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(BNavbarIcons.home, height: 29, width: 29, color: _selectedPage == 0 ? const Color(0xFF6340AD) : null),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(BNavbarIcons.history, height: 29, width: 29, color: _selectedPage == 1 ? const Color(0xFF6340AD) : null),
            ),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(BNavbarIcons.pay, height: 29, width: 29, color: _selectedPage == 2 ? const Color(0xFF6340AD) : null),
            ),
            label: 'Demand',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
