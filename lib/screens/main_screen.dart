import 'package:flutter/material.dart';
import 'package:my_multivender_ecommerce_app/screens/category_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/home_screen.dart';
import 'package:my_multivender_ecommerce_app/message_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/account_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/cart_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:my_multivender_ecommerce_app/screens/orderItem_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/ProfilePage.dart'; // Import the profile page

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({this.index, Key? key}) : super(key: key);
  static const routName = '/home-rout';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    CategoryScreen(),
    OrederItemScreen(),
    CartScreen(),
    //ProfilePage(), // Replace AccountScreen with ProfilePage
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      // If the selected index is 4 (Profile), navigate to the ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 2 ? IconlyBold.bag2 : IconlyLight.bag2),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? IconlyBold.buy : IconlyLight.buy,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 4 ? IconlyBold.profile : IconlyLight.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
      ),
    );
  }
}
