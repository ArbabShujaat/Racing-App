import 'package:flutter/material.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Screens/ShopsScreens/details/details_screen.dart';
import 'package:racingApp/models/Cars.dart';
import 'package:racingApp/models/Clothes.dart';

import 'item_card.dart';

int selectedIndex = 0;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> clothesCategories = [
    "New in",
    "Men",
    "Women",
    "Accessories",
    "Shoes",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: clothesCategories.length,
              itemBuilder: (context, index) => buildCategory(index),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: selectedIndex == 0
              ? categoryItems(newInClothes)
              : selectedIndex == 1
                  ? categoryItems(menClothes)
                  : selectedIndex == 2
                      ? categoryItems(womenClothes)
                      : selectedIndex == 3
                          ? categoryItems(accessories)
                          : categoryItems(sheos),
        ))
      ],
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        print(selectedIndex);
        (context as Element).reassemble();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              clothesCategories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 80,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Widget categoryItems(List<Product> categoryList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: GridView.builder(
          itemCount: categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPaddin,
            crossAxisSpacing: kDefaultPaddin,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ItemCard(
                product: categoryList[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: categoryList[index],
                      ),
                    )),
              )),
    );
  }
}
