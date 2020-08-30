import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Widgets/custom_textfield.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';
import 'package:racingApp/services/payment_service.dart';

class AddCarScreen extends StatefulWidget {
  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  UserModel userProfile;

  bool _selectProductCategory = false;
  String _productCategory = '';
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool signupLoading = false;
  String imageUrl;
  var _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextEditingController productTitleController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController productPriceNumberContoller = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productIDController = TextEditingController();

  @override
  void dispose() {
    productIDController.dispose();
    productDescriptionController.dispose();
    productPriceNumberContoller.dispose();
    productTitleController.dispose();
    languageController.dispose();
    countryController.dispose();
    super.dispose();
  }

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
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    userProfile = Provider.of<User>(context).userProfile;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    ///Main function for screen ui
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),

                //acceptTermsTextRow(),
                SizedBox(
                  height: _height / 17,
                ),
                addProductButton(context),
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: _height / 5,
              width: _width / 1.5,
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
                // shape: BoxShape.circle,
              ),
              child: pic(),
            ),
          ],
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
            productidTextFormField(),
            SizedBox(
              height: _height / 60.0,
            ),
            titleTextFormField(),
            SizedBox(height: _height / 60.0),
            priceTextFormField(),
            SizedBox(height: _height / 60.0),
            descriptionTextFormField(),
            SizedBox(height: _height / 60.0),

            ///Product Category ui you can set it up else where if you want
            ///and reference it here
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Row to show delivery time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Category:",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _productCategory,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_selectProductCategory == false)
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              //_deliveryTime = snapshot.data.documents[index].data['deliveryTime'];
                              _selectProductCategory = true;
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_drop_down)),
                        ),
                    ],
                  ),

                  ///Payment Method Buttons

                  ///selecting product category
                  if (_selectProductCategory == true)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _productCategory = "Car";
                            _selectProductCategory = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Car",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  if (_selectProductCategory == true)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _productCategory = "Sports Car";
                            _selectProductCategory = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sports Car",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  if (_selectProductCategory == true)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _productCategory = "Car Parts";
                            _selectProductCategory = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Car Parts",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Custom form fields for form elements section
  Widget productidTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.person,
      hint: "Product ID e.g 721926",
      textEditingController: productIDController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "ID must not be empty";
        }
        return null;
      },
    );
  }

  Widget titleTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Title",
      textEditingController: productTitleController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Title must not be empty";
        }
        return null;
      },
    );
  }

  Widget priceTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.numberWithOptions(signed: true),
      obscureText: false,
      icon: Icons.phone,
      hint: "Price",
      textEditingController: productPriceNumberContoller,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Price must not be empty";
        }
        return null;
      },
    );
  }

  Widget descriptionTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: false,
      icon: Icons.card_travel,
      hint: "Vehicle Details",
      textEditingController: productDescriptionController,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Vehicle Details must not be empty";
        }
        return null;
      },
    );
  }

  ///Sign Up button function
  //TODO form validation for sign up form
  Widget addProductButton(BuildContext ctx) {
    return signupLoading
        ? CircularProgressIndicator()
        : RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () async {
              //Condition to see if profile image is uploaded
              if (imagecheck &&
                  _formKey.currentState.validate() &&
                  _productCategory != "") {
                addProduct(ctx);
              } else if (_productCategory == "") {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.red[400],
                          )),
                      title: Text("Wait..."),
                      content: Text("Category Not Selected"),
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
                'Add Product',
                style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 12)),
              ),
            ),
          );
  }

  ///Firebase creating user with email & password and error handling
  Future<void> addProduct(BuildContext ctx) async {
    try {
      if (userProfile.email == null) {
        throw Exception;
      }
      StripeTransactionResponse response =
          await StripeService.payViaNewCard(amount: '200', currency: 'USD');
      if (response.success == true) {
        setState(() {
          signupLoading = true;
        });
        await addProductToStore(userProfile);
      }

      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text('Your product has been added.'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(PRIMARY_SCREEN, (route) => false);
                },
              )
            ],
          ));

      setState(() {
        signupLoading = false;
      });
      

    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });
//    throw signUpError;
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text(signUpError.toString()),
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

  ///function to add user data to a firebase collection
  Future<void> addProductToStore(UserModel userModel) async {
    await Firestore.instance.collection("carproducts").add({
      'datetime': Timestamp.now(),
      'productid': productIDController.text,
      'title': productTitleController.text,
      'productdetails': productDescriptionController.text,
      'productprice': productPriceNumberContoller.text,
      'productimage': imageUrl,
      'productcategory': _productCategory,
//      'status': 'inactive',
      'selleruseruid': userModel.useruid,
      'selleremail': userModel.email,
      'sellerphonenumber': userModel.phonenumber
    });
  }

  ///Picking up user profile image
  Widget pic() {
    return imagecheck
        ? Container(
            height: _height / 5,
            width: _width / 1.5,
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
          )
        : GestureDetector(
            onTap: () async {
              image = await pickImage(context, ImageSource.gallery);

              if (image != null) {
                setState(() {
                  imagecheck = true;
                });

                final FirebaseStorage _storgae = FirebaseStorage(
                    storageBucket: 'gs://racing-app-55a9e.appspot.com/');
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
