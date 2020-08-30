import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (prefs.getBool('FirstTime') == null)
      Navigator.of(context).pushReplacementNamed(WELCOME_PAGE);
    else
      currentUser != null
          ? Provider.of<User>(context)
              .getCurrentUserData(currentUser.uid)
              .then((value) {
              Navigator.of(context).pushReplacementNamed(NAVABAR_SCREEN);
            })
          : Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
  }

  @override
  Future<void> initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red[700],
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/logo.png',
              width: animation.value * 200,
              height: animation.value * 200,
            ),
            SizedBox(
              height: 70,
            ),
            SpinKitCircle(
              size: 40,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven ? Colors.white : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
