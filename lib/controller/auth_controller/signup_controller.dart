import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/views/login_screen.dart';
 
class SignupController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isSigningUp = false;

  void checkAllFieldsAreFilled(context) {
     
    if (firstNameController.text == ' ' ||
        lastNameController.text == ' ' ||
        emailController.text == ' ' ||
        passwordController.text == ' ' ||
        cPasswordController.text == ' ' ) {
          isSigningUp = false;
      Fluttertoast.showToast(
        msg: "Please fill all the fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      checkIsPassCorrect(context);
     
    }
    notifyListeners();
  }

  void checkIsPassCorrect(context) {
    String pass = passwordController.text;
    String cPass = cPasswordController.text;
    if (pass == cPass) {
       signUp(context);
        
    } else {
      isSigningUp = false;
      Fluttertoast.showToast(
        msg: "Password & Confirm Password Don't Match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    notifyListeners();
  }

 Future<void> signUp(BuildContext context) async {
  String email = emailController.text;
  String password = passwordController.text;
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

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String uid = userCredential.user!.uid;

    saveUserData(context, uid);
  } catch (e) {
    isSigningUp = false;
    log(e.toString());
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

  Future<void> saveUserData(context, String uid) async {
    try {
      String email = emailController.text;
       

      Map<String, dynamic> userData = {
        'email': email,
        'fname': firstNameController.text,
        'lname': lastNameController.text,
        'uid':uid
      };

      await firestore.collection('users').doc(uid).set(userData).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );

        isSigningUp = false;
      });
      Fluttertoast.showToast(
          msg: 'User Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      log(e.toString());
      isSigningUp = false;
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }
  
}
