import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Widgets/custom_shape.dart';
import 'package:racingApp/Widgets/custom_textfield.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool loginLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  ///main ui function for screen
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Opacity(opacity: 0.88, child: CustomAppBar()),
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              // forgetPassTextRow(),
              SizedBox(height: _height / 12),
              button(),
              SizedBox(
                height: 20,
              ),
              signUpTextRow()

              // signUpTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  ///design at the top of the page ui
  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
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
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red[400], Colors.red[100]])),
            ),
          ),
        ),
      ],
    );
  }

  ///welcome text ui
  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 120),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  ///sign in text at the top ui
  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  ///UI section for login form
  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  ///FOrm fields for login form
  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: "Email ID",
      validator: (String val) {
        if (val.trim().isEmpty) {
          return 'Email must not be empty';
        }
        return null;
      },
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
      validator: (String val) {
        if (val.trim().isEmpty) {
          return "Passworm must not be empty";
        }
        return null;
      },
    );
  }

  ///Forget Password section functions
  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Hexcolor("#3FBCFF")),
            ),
          )
        ],
      ),
    );
  }

  ///Button for logging in and its functions
  Widget button() {
    return loginLoading
        ? CircularProgressIndicator()
        : RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () async {
              //check if form is valid and then sign in and store data in shared prefs
              if (_key.currentState.validate()) {
                setState(() {
                  loginLoading = true;
                });
                try {
                  final AuthResult user =
                      (await _auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  ));
                  // .user;
                  //check user if not null save data to shared prefs
                  // and navigate to next page
                  if (user != null) {
                    // showInSnackBar("Login Succesfull");
//                    var prefs = await SharedPreferences.getInstance();
//                    final userData = json.encode(
//                      {
//                        'userEmail': user.user.email,
//                        'userUid': user.user.uid,
//                        'password': passwordController.text,
//                      },
//                    );
//                    prefs.setString('userData', userData);

                    String userEmail = user.user.email;
                    String userUid = user.user.uid;

                    Provider.of<User>(context)
                        .getCurrentUserData(userUid)
                        .then((value) {
                      Navigator.of(context)
                          .pushReplacementNamed(NAVABAR_SCREEN);
                    });
                    setState(() {
                      loginLoading = false;
                    });

                    // setState(() {
                    //   _success = true;
                    //   _userEmail = user.email;
                    // });
                  }
                } catch (signUpError) {
                  setState(() {
                    loginLoading = false;
                  });

                  ///Error Catching phase
                  if (signUpError is PlatformException) {
                    if (signUpError.code == 'ERROR_INVALID_EMAIL') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red[400],
                                )),
                            title: Text("Incorrect Email"),
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

                    if (signUpError.code == 'ERROR_WRONG_PASSWORD') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red[400],
                                )),
                            title: Text("Wrong Password"),
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

                    if (signUpError.code == 'ERROR_USER_NOT_FOUND') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red[400],
                                )),
                            title: Text("No user exists"),
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
            },

            // onPressed: () {
            //     print("Routing to your account");

            //     Scaffold
            //         .of(context)
            //         .showSnackBar(SnackBar(content: Text('Login Successful')));

            // },
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
              width: _large
                  ? _width / 4
                  : (_medium ? _width / 3.75 : _width / 3.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                      colors: [Colors.red[400], Colors.red[100]])),
              padding: const EdgeInsets.all(12.0),
              child: Text('SIGN IN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _large ? 16 : (_medium ? 14 : 12))),
            ),
          );
  }

  ///Function to go to signup page for creating account
  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGNUP_SCREEN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.red[400],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
