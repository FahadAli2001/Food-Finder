import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/home_screen.dart';

class EditProfileController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  File? image;
  bool isUpdating = false;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> fetchUserDataAndAssignToControllers(String uid) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        firstNameController.text = userData['fname'] ?? '';
        lastNameController.text = userData['lname'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phone'] ?? '';
        cityController.text = userData['city'] ?? '';
      }
    } catch (e) {
      log('Error fetching user data: $e');
      Fluttertoast.showToast(
        msg: 'Error fetching user data: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

Future<void> uploadUserDataAndImage(String uid, context) async {
  isUpdating = true;
  try {
    String? imageUrl = await uploadImageToFirebase(); // Wait for the image upload to complete
    UserModel newUser = UserModel(
      fname: firstNameController.text,
      lname: lastNameController.text,
      email: emailController.text,
      uid: uid,
      profileImage: imageUrl,
      phone: phoneController.text,
      city: cityController.text,
    );
    Map<String, dynamic> userData = newUser.toJson();

    await usersCollection.doc(uid).set(userData).then((value) {
      clearFields();
      isUpdating = false;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userModel: newUser,
          ),
        ),
        (route) => false,
      );
      Fluttertoast.showToast(
        msg: 'User Data Updated',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  } catch (e) {
    log('Error uploading user data and image: $e');
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}


  Future<String?> uploadImageToFirebase() async {
    try {
      String fileName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate a unique file name
      Reference ref =
          FirebaseStorage.instance.ref().child('profiles').child(fileName);
      UploadTask uploadTask = ref.putFile(image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  void clearFields() {
    firstNameController.clear();
    lastNameController.clear();
    cityController.clear();
    phoneController.clear();
    emailController.clear();
  }
}
