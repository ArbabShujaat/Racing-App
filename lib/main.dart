import 'package:provider/provider.dart';
import 'package:racingApp/Screens/Cart/shoppingCart.dart';
import 'package:racingApp/Screens/EventsScreen.dart/EventList.dart';
import 'package:racingApp/Screens/ProfileScreen/profileScreen.dart';
import 'package:racingApp/Screens/Registration/login.dart';
import 'package:racingApp/Screens/Registration/signup.dart';
import 'package:racingApp/Screens/WelcomeScreens/getStartedScreen.dart';
import 'package:racingApp/Screens/orders/order_history.dart';
import 'package:racingApp/Screens/primary_screen.dart';
import 'package:racingApp/Screens/WelcomeScreens/sider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Constants/constant.dart';
import 'Providers/user.dart';
import 'Screens/ChatScreens/all_chats_screen.dart';
import 'Screens/EventsScreen.dart/EventsScreen.dart';
import 'Screens/MapsScreens.dart/map_screen_initializer.dart';
import 'Screens/NavBar.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        )
      ],
      child: MaterialApp(
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
          FULL_MAP: (BuildContext context) => MapInitializer(),
          EVENT_SCREEN: (BuildContext context) => EventScreen(),
          EVENTLIST_SCREEN: (BuildContext context) => EventList(),
          NAVABAR_SCREEN: (BuildContext context) => BottomNav(),
          CHAT_SCREEN: (BuildContext context) => AllChatsScreen(),
          CART_SCREEN: (BuildContext context) => CartScreen(),
          ORDER_HISTORY: (BuildContext context) => OrderHistory()
        },
        initialRoute: SPLASH_SCREEN,
      ),
    );
  }
}
