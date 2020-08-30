// import 'dart:ffi';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:racingApp/Screens/Cart/shoppingCart.dart';
import 'package:racingApp/Screens/ChatScreens/all_chats_screen.dart';
import 'package:racingApp/Screens/ProfileScreen/profileScreen.dart';
import 'package:racingApp/Screens/primary_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int pageIndex = 0;
  bool animate = true;
  PrimaryScreen _home;
  AllChatsScreen _chat;
  Profile _profile;
  CartScreen _cart;

  Widget _showPage;
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _home;

      case 1:
        return _chat;

      case 2:
        return _cart;

      case 3:
        return _profile;
      default:
        return new Container(
            child: new Center(
          child: new Text(
            'No Page found by page thrower',
            style: new TextStyle(fontSize: 30),
          ),
        ));
    }
  }

  @override
  void initState() {
    super.initState();
    _home = PrimaryScreen();
    _chat = AllChatsScreen();
    _profile = Profile();
    _cart = CartScreen();

    pageIndex = 0;
    _showPage = _pageChooser(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 18,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_bubble,
            size: 18,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 18,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 18,
            color: Colors.white,
          ),
        ],
        color: Colors.red,
        height: 60,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int tappedIndex) {
          setState(() {
            animate = true;
            pageIndex = tappedIndex;
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}
