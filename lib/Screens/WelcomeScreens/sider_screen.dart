import 'package:racingApp/Constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:intro_slider_example/home.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "LIVE MAPS",
          styleTitle: TextStyle(
              color: Colors.red[400],
              fontSize: 20.0,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold),
          description:
              "Desrciptionof the Desrciptionof theDesrciptionof theDesrciptionof theDesrciptionof the",
          styleDescription: TextStyle(
              color: Colors.grey, fontSize: 15.0, fontFamily: 'Raleway'),
          pathImage: "assets/maps.png",
          foregroundImageFit: BoxFit.cover,
          // backgroundImage:"assets/maps.png",
          widthImage: 200,
          heightImage: 300),
    );
    slides.add(
      new Slide(
          title: "BUY CAR AND PARTS",
          styleTitle: TextStyle(
              color: Colors.red[400],
              fontSize: 20.0,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold),
          description:
              "Desrciptionof the Desrciptionof theDesrciptionof theDesrciptionof theDesrciptionof the",
          styleDescription: TextStyle(
              color: Colors.grey, fontSize: 15.0, fontFamily: 'Raleway'),
          pathImage: "assets/car.jpg",
          foregroundImageFit: BoxFit.cover,
          // backgroundImage:"assets/maps.png",
          widthImage: 200,
          heightImage: 300),
    );
    slides.add(
      new Slide(
          title: "BUY SPORT CLOTHES",
          styleTitle: TextStyle(
              color: Colors.red[400],
              fontSize: 20.0,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold),
          description:
              "Desrciptionof the Desrciptionof theDesrciptionof theDesrciptionof theDesrciptionof the",
          styleDescription: TextStyle(
              color: Colors.grey, fontSize: 15.0, fontFamily: 'Raleway'),
          pathImage: "assets/clothes.jpg",
          foregroundImageFit: BoxFit.cover,
          // backgroundImage:"assets/maps.png",
          widthImage: 200,
          heightImage: 300),
    );
  }

  Future<void> onDonePress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('FirstTime', true);
    Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.red[400],
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "DONE",
      style: TextStyle(color: Colors.red[400]),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      "SKIP",
      style: TextStyle(color: Colors.red[400]),
    );
    // return Icon(
    //   Icons.skip_next,
    //   color: Color(0xffffcc5c),
    // );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height / 1.2,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: IntroSlider(
              // List slides
              slides: this.slides,

              // Skip button
              renderSkipBtn: this.renderSkipBtn(),
              onSkipPress: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('FirstTime', true);
                Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
              },
              // colorSkipBtn: Colors.green,
              highlightColorSkipBtn: Colors.red[100],

              // Next button
              renderNextBtn: this.renderNextBtn(),

              // Done button
              renderDoneBtn: this.renderDoneBtn(),
              onDonePress: this.onDonePress,
              // colorDoneBtn: Color(0x33ffcc5c),
              highlightColorDoneBtn: Colors.red[100],

              // Dot indicator
              colorDot: Colors.red[400],
              sizeDot: 13.0,
              typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

              // Tabs
              listCustomTabs: this.renderListCustomTabs(),
              backgroundColorAllSlides: Colors.white,
              refFuncGoToTab: (refFunc) {
                this.goToTab = refFunc;
              },

              // Show or hide status bar
              shouldHideStatusBar: true,

              // On tab change completed
              onTabChangeCompleted: this.onTabChangeCompleted,
            ),
          ),
        ],
      ),
    );
  }
}
