import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteItemsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> checkFavorite(String documentId, String name, String rating,
      String reviewCount, String description, String imageUrl,List ingredients) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('favorites').doc(documentId).get();
      if (documentSnapshot.exists) {
          await _firestore.collection('favorites').doc(documentId).delete();
      } else {
        log('Document does not exist');
        markFavorite(documentId, name, rating, reviewCount, description, imageUrl, ingredients);
      }
    } catch (e) {
      log('Error fetching document: $e');
    }
  }

  Future<void> markFavorite(String documentId, String name, String rating,
      String reviewCount, String description, String imageUrl,List ingredients) async {
    try {
      _firestore.collection('favorites').doc(documentId).set({
        "title": name,
        "rating": rating,
        "instructions": description,
        "imageUrl": imageUrl,
        "reviewCount": reviewCount,
        "ingredients":ingredients
      });
    } catch (e) {
      log('Error marking favorite: $e');
     }
  }
}
