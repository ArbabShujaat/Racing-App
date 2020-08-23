import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Screens/ShopsScreens/CarsHomeScreen/addNewCar/add_new_car.dart';

import 'components/body.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddCarScreen();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "SELL",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primarycolor,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Text(
          "Cars And Parts",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
//        IconButton(
//          icon: SvgPicture.asset(
//            "assets/icons/search.svg",
//            // By default our  icon color is white
//            color: Colors.white,
//          ),
//          onPressed: () {},
//        ),
      ],
    );
  }
}
