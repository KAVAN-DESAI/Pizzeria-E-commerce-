import 'package:ecommerce_app/helper/constants.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/views/cart.dart';
import 'package:ecommerce_app/views/home.dart';
import 'package:ecommerce_app/views/myProduct.dart';
import 'package:ecommerce_app/views/profile.dart';
import 'package:ecommerce_app/views/search.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class homeCustomer extends StatefulWidget {
  @override
  final bool isCustomer;
  homeCustomer(this.isCustomer);
  _homeCustomerState createState() => _homeCustomerState();
}

class _homeCustomerState extends State<homeCustomer> {
  @override
  var _selectedTab = _SelectedTab.home;
  int _selectedTabIndex=0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      _selectedTabIndex=i;
    });
  }

  List<Widget> listScreens = [
    home(),
    SearchPlatform(),
    myProduct(),
    userProfile(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Pizzeria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.white),),
          leading:Icon(Icons.more_vert),
          elevation: 0, backgroundColor: Colors.blue,
          actions: [
        GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => cart()));
            },
            child: Icon(Icons.shopping_cart, color: Colors.white,size: 30)
        )
      ]
      ),
      body: listScreens[_selectedTabIndex],
      bottomNavigationBar:  DotNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        marginR : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        backgroundColor: Colors.grey[300],
        onTap: _handleIndexChanged,
        // dotIndicatorColor: Colors.black,
        enableFloatingNavBar: true,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home),
            selectedColor: Colors.purple,
          ),

          /// Likes
          DotNavigationBarItem(
            icon: Icon(Icons.search),
            selectedColor: Colors.pink,
          ),

          /// Search
          DotNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            selectedColor: Colors.orange,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: Colors.teal,
          ),

        ],
      ),
    );
  }
}

enum _SelectedTab { home, search, order, person }