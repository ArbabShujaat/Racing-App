import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Widgets/custom_shape.dart';
import 'package:racingApp/Widgets/custom_textfield.dart';
import 'package:racingApp/Widgets/customappbar.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool signupLoading = false;
  String imageUrl;
  var _formKey = GlobalKey<FormState>();

  TextEditingController firstnameController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberContoller = TextEditingController();
  TextEditingController vehicleDetailsController = TextEditingController();

  bool imagecheck = false;
  File image;

  String filename;
  bool urlcheck = false;

  @override
  Future<void> didChangeDependencies() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.photos
    ].request();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    ///Main function for screen ui
    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),

                //acceptTermsTextRow(),
                SizedBox(
                  height: _height / 17,
                ),
                button(),
                // infoTextRow(),
                // socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Function to make pick profile image ui
  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red[400], Colors.red[100]])),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red[400], Colors.red[100]])),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: pic(),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  ///Sign up form ui here
  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            nameTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            vehicleTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
          ],
        ),
      ),
    );
  }

  ///Custom form fields for form elements section
  Widget nameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Name",
      textEditingController: firstnameController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Name must not be empty";
        }
        return null;
      },
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
      textEditingController: emailController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Email must not be empty";
        }
        return null;
      },
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
      textEditingController: passwordController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Password must not be empty";
        }
        return null;
      },
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.numberWithOptions(signed: true),
      obscureText: false,
      icon: Icons.phone,
      hint: "Phone Number",
      textEditingController: phoneNumberContoller,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Number must not be empty";
        }
        return null;
      },
    );
  }

  Widget vehicleTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: false,
      icon: Icons.card_travel,
      hint: "Vehicle Details",
      textEditingController: vehicleDetailsController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Vehicle Details must not be empty";
        }
        return null;
      },
    );
  }

  ///Terms and conditions checkbox
  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red[400],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  ///Sign Up button function
  //TODO form validation for sign up form
  Widget button() {
    return signupLoading
        ? CircularProgressIndicator()
        : RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () async {
              //Condition to see if profile image is uploaded
              if (imagecheck && _formKey.currentState.validate()) {
                signUp();
              } else {
                imagecheck == false
                    ? showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.red[400],
                              )),
                          title: Text("Wait..."),
                          content: Text("Image Not Uploaded"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.red[400]),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ))
                    : null;
              }
            },
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
//        height: _height / 20,
              width: _large
                  ? _width / 4
                  : (_medium ? _width / 3.75 : _width / 3.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                      colors: [Colors.red[400], Colors.red[100]])),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'SIGN UP',
                style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 12)),
              ),
            ),
          );
  }

  ///Create account with social media function
  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  ///Going to sign in Page function
  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(LOGIN_SCREEN);

              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }

  ///Firebase creating user with email & password and error handling
  Future<void> signUp() async {
    setState(() {
      signupLoading = true;
    });
    try {
      final AuthResult user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      if (user != null) {
//        var prefs = await SharedPreferences.getInstance();
//        final userData = json.encode(
//          {
//            'userEmail': user.user.email,
//            'userUid': user.user.uid,
//            'password': passwordController.text,
//          },
//        );
//        prefs.setString('userData', userData);
        String userEmail = user.user.email;
        String userUid = user.user.uid;

        await addUsertoFirebase(userUid);

        Provider.of<User>(context).getCurrentUserData(userUid).then((value) {
          Navigator.of(context).pushReplacementNamed(NAVABAR_SCREEN);
        });
        setState(() {
          signupLoading = false;
        });

        // setState(() {
        //   _success = true;
        //   _userEmail = user.email;
        // }

      }
    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });

      //Error handling
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Email already in use"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Weak Password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Invalid Email"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }
      }
    }
  }

  ///function to add user data to a firebase collection
  Future<void> addUsertoFirebase(String userUid) async {
    await Firestore.instance.collection("Users").document(userUid).setData({
      'email': emailController.text,
      'name': firstnameController.text,
      'vehicedetails': vehicleDetailsController.text,
      'phonenumber': phoneNumberContoller.text,
      'useruid': userUid,
      'userimage': imageUrl,
      'location': 'disabled'
    });
  }

  ///Picking up user profile image
  Widget pic() {
    return imagecheck
        ? CircleAvatar(maxRadius: 65, backgroundImage: FileImage(image))
        : GestureDetector(
            onTap: () async {
              image = await pickImage(context, ImageSource.gallery);

              if (image != null) {
                setState(() {
                  imagecheck = true;
                });

                final FirebaseStorage _storgae = FirebaseStorage(
                    storageBucket: 'gs://speakany-94f37.appspot.com/');
                StorageUploadTask uploadTask;
                String filePath = '${DateTime.now()}.png';
                uploadTask = _storgae.ref().child(filePath).putFile(image);
                uploadTask.onComplete.then((_) async {
                  print(1);
                  String url1 =
                      await uploadTask.lastSnapshot.ref.getDownloadURL();
                  image.delete().then((onValue) {
                    setState(() {
                      urlcheck = true;
                    });
                    print(2);
                  });
                  print(url1);

                  imageUrl = url1;
                  filename = filePath;
                  print(filename);
                });
              }
            },
            child: Icon(Icons.add_a_photo,
                size: _large ? 40 : (_medium ? 33 : 31),
                color: Colors.red[400]));
  }

  Future<File> pickImage(BuildContext context, ImageSource source) async {
    File selected = await ImagePicker.pickImage(
      source: source,
      imageQuality: 20,
    );
    return selected;
  }
}
