import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class UserModel {
  String useruid;
  String name;
  String userimage;
  String phonenumber;
  String email;
  String vehicledetails;
  String location;

  UserModel(
      {@required this.email,
        @required this.name,
        @required this.phonenumber,
        @required this.userimage,
        @required this.useruid,
      @required this.vehicledetails,
      @required this.location});
}

class User with ChangeNotifier{
  UserModel _userProfile ;
  UserModel get userProfile => _userProfile;
  String _currentUserId;
  String get currentUserId => _currentUserId;
  String location;
//  String _currentUserEmail;
//  String get currentUserEmail => _currentUserEmail;
//  Future<void> getCurrentUser()async{
//    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//    _currentUserId = currentUser.uid;
//    _currentUserEmail = currentUser.email;
//  }

  Future<void> getCurrentUserData(String useruid)async{
    _currentUserId = useruid;
    await Firestore.instance.collection('Users').document(_currentUserId).get().then((value){
      _userProfile = convertToUserModel(value);
      print("user data fetched");
    }).catchError((error) {
      throw error;
    });

    notifyListeners();
  }

  UserModel convertToUserModel(DocumentSnapshot docu) {
    var doc = docu.data;
    location = doc['location'];
    return UserModel(
      name: doc['name'],
      email: doc['email'],
      phonenumber: doc['phonenumber'],
      userimage: doc['userimage'],
      useruid: doc['useruid'],
      vehicledetails: doc['vehicedetails'],
      location: doc['location']
    );
  }

}