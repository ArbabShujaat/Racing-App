import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Screens/ShopsScreens/details/details_screen.dart';
import 'package:racingApp/models/Cars.dart';

import 'categorries.dart';
import 'item_card.dart';

int selectedIndex = 0;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> carsCategories = ["Cars", "Sport Cars", "Parts"];
  List<IconData> clothesCategoriesIcon = [
    Ionicons.ios_car,
    Ionicons.ios_speedometer,
    FontAwesome.gears
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 8.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: carsCategories.length,
              itemBuilder: (context, index) => buildCategory(index),
            ),
          ),
        ),
        Expanded(
          child: selectedIndex == 0
              ? categoryItems(car, carsCategories[0])
              : selectedIndex == 1
                  ? categoryItems(sportsCars, carsCategories[1])
                  : categoryItems(autoParts, carsCategories[2]),
        )
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(6, 2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                  BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      offset: Offset(-6, -2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0)
                ], shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(clothesCategoriesIcon[index],
                      size: 40, color: Colors.red),
                )),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                carsCategories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: selectedIndex == index ? kTextColor : kTextLightColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItems(List<Product> categoryList, String category) {
    var productCategory = 'Car';
    if (category == carsCategories[1]) {
      productCategory = 'Car';
    } else if (category == carsCategories[2]) {
      productCategory = "Car Parts";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('carproducts')
              .where('productcategory', isEqualTo: productCategory)
              .orderBy('datetime', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final snapShotData = snapshot.data.documents;
            if (snapShotData.length == 0) {
              return Center(
                child: Text("No products added"),
              );
            }
            return GridView.builder(
                itemCount: snapShotData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  var doc = snapShotData[index].data;

                  //Create a product item to pass as arugument
                  Productc product = Productc(
                      image: doc['productimage'],
                      price: doc['productprice'],
                      description: doc['productdetails'],
                      id: doc['productid'],
                      title: doc['title'],
                      sellerEmail: doc['selleremail'],
                      sellerPhoneNumber: doc['sellerphonenumber'],
                      sellerUserUid: doc['selleruseruid'],
                      productCategory: doc['productcategory'],
                      sellerName: doc['sellername']);
                  //-----------------------------------------

                  return ItemCard(
                    product: product,
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: product,
                          ),
                        )),
                  );
                });
          }),
    );
  }
}
