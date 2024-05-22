import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteItemsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> checkFavorite(
      String documentId,
      String name,
      String rating,
      String reviewCount,
      String description,
      String imageUrl,
      List ingredients,
       String apiName,
      ) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('favorites').doc(documentId).get();

      if (documentSnapshot.exists) {
        await _firestore.collection('favorites').doc(documentId).delete();
        Fluttertoast.showToast(
          msg: "Bookmark Removed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        log('Document does not exist');
        markFavorite(documentId, name, rating, reviewCount, description,
            imageUrl, ingredients,apiName);
        Fluttertoast.showToast(
          msg: "Bookmark Added",
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
      String imageUrl,
      List ingredients,
      String apiName
      ) async {
    try {
      _firestore.collection('favorites').doc(documentId).set({
        "title": name,
        "rating": rating,
        "instructions": description,
        "imageUrl": imageUrl,
        "reviewCount": reviewCount,
        "ingredients": ingredients,
        "apiName":apiName
      });
    } catch (e) {
      log('Error marking favorite: $e');
    }
  }
}
