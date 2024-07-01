import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/welcome_screen.dart';
  import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool rememberMe = false;
  bool islogingIn = false;
  UserModel? userModel;

  Future<void> loginUser(BuildContext context) async {
  String email = emailController.text;
  String password = passwordController.text;

  SharedPreferences sp = await SharedPreferences.getInstance();
  try {
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(
        msg: 'Please enter a valid email address',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      
    }

    islogingIn = true;
    log(islogingIn.toString());
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String uid = userCredential.user!.uid;
    sp.setString('uid', uid);
    userModel = await fetchUserData(uid);

    if (userModel != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userModel: userModel!,
          ),
        ),
        (route) => false,
      );
      emailController.clear();
      passwordController.clear();
    }

    islogingIn = false;
  } catch (e) {
    islogingIn = false;
    log(e.toString());
    log(islogingIn.toString());

    // Fluttertoast.showToast(
    //   msg: e.toString(),
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }
  notifyListeners();
}

  Future<UserModel?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      log(userModel.email!);
      return userModel;
    } catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
    return userModel;
  }

  Future<void> checkIsRememberMe(context) async {
  
    if (rememberMe == true) {
      savedUserLogin(context);
    } else {
      loginUser(context);
    }
  }

  void savedUserLogin(context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginUser(context);
    sp.setBool('rememberMe', rememberMe);
  }

  void signOut(context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    auth.signOut();
    sp.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }
}
