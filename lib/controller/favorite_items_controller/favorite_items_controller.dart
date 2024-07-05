import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteItemsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> checkFavorite(
  String? documentId,
  String name,
  String rating,
  String reviewCount,
  String description,
  var imageUrl,
  List ingredients,
  String apiName,
) async {
  try {
    String docId = documentId?? apiName;
    DocumentSnapshot documentSnapshot = await _firestore
       .collection('favorites')
       .doc(docId)
       .get();

    if (documentSnapshot.exists) {
      await _firestore
         .collection('favorites')
         .doc(docId)
         .delete();
      log("DELET");
      Fluttertoast.showToast(
        msg: "Recipe Removed From Saved List",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      log('Document does not exist');
      markFavorite(docId, name, rating, reviewCount, description, imageUrl, ingredients, apiName);
      Fluttertoast.showToast(
        msg: "Recipe Added To Saved List",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    log('Error fetching document: $e');
  }
}

 Future<void> markFavorite(
  String documentId,
  String name,
  String rating,
  String reviewCount,
  String description,
  var imageFile,
  List ingredients,
  String apiName,
) async {
  try {
    String imageUrl;
    if (imageFile is File) {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("favorites/$documentId.jpg");
      await imageRef.putFile(imageFile);

      // Get the download URL
      imageUrl = await imageRef.getDownloadURL();
    } else {
      // Assume imageFile is a URL
      imageUrl = imageFile;
    }

    // Save data to Firestore
    _firestore.collection('favorites').doc(documentId).set({
      "title": name,
      "rating": rating,
      "instructions": description,
      "imageUrl": imageUrl,
      "reviewCount": reviewCount,
      "ingredients": ingredients,
      "apiName": apiName
    });
  } catch (e) {
    log('Error marking favorite: $e');
  }
}
}
