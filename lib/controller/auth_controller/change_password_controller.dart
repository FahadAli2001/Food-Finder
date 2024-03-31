import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/model/user_model.dart';

class ChangePasswordController {
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  UserModel? userModel;

  FirebaseAuth auth = FirebaseAuth.instance;

  void checkFields() {
    log("checkfield");
    if (cPassController.text == '' ||
        newPassController.text == ' ' ||
        passController.text == ' ') {
      log('fill fields');
      Fluttertoast.showToast(
          msg: 'Please fill all the fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      checkPassword();
    }
  }

  void checkPassword() {
    if (newPassController.text == cPassController.text) {
      changePassword(newPassController.text);
      clearfields();
       Fluttertoast.showToast(
          msg: "Password changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Password don't match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        // Update the password
        await user.updatePassword(newPassword);
        log('Password updated successfully');
      }
    } catch (e) {
      log('Error changing password: $e');
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void clearfields(){
    newPassController.clear();
    passController.clear();
    cPassController.clear()
    ;
  }
}
