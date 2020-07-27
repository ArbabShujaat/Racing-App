import 'package:racingApp/Screens/MapsScreens.dart/maps_full_screen.dart';
import 'package:racingApp/Screens/ProfileScreen/profileScreen.dart';
import 'package:racingApp/Screens/Registration/login.dart';
import 'package:racingApp/Screens/Registration/signup.dart';
import 'package:racingApp/Screens/WelcomeScreens/getStartedScreen.dart';
import 'package:racingApp/Screens/primary_screen.dart';
import 'package:racingApp/Screens/WelcomeScreens/sider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:racingApp/models/Events.dart';

import 'Constants/constant.dart';
import 'Screens/EventsScreen.dart/EventsScreen.dart';
import 'Screens/ShopsScreens/CarsHomeScreen/car_shop_homeScreen.dart';

import 'Screens/ShopsScreens/ClothesHomeScreen/clothes_shop_homeScreen.dart';
import 'Screens/WelcomeScreens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Racing App",
      theme: ThemeData(primaryColor: Colors.red, primarySwatch: Colors.red),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        SLIDER_SCREEN: (BuildContext context) => IntroScreen(),
        PRIMARY_SCREEN: (BuildContext context) => PrimaryScreen(),
        SIGNUP_SCREEN: (BuildContext context) => SignUpScreen(),
        LOGIN_SCREEN: (BuildContext context) => SignInPage(),
        WELCOME_PAGE: (BuildContext context) => WelcomePage(),
        CAR_SHOP_PAGE: (BuildContext context) => ShopHomeScreen(),
        CLOTHES_SHOP_PAGE: (BuildContext context) => ClothesHomeScreen(),
        PROFILE: (BuildContext context) => Profile(),
        FULL_MAP: (BuildContext context) => FullScreenMap(),
        EVENT_SCREEN: (BuildContext context) => EventScreen(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}
