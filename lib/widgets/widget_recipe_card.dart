 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/favorite_items_controller/favorite_items_controller.dart';

// ignore: must_be_immutable
class RecipeCard extends StatelessWidget {
  final String apiName;
  final String name;
  final String id;
  final String rating;
  final String reviewCount;
  final String description;
  final String imageUrl;
  final List? ingredients;

  RecipeCard(
      {super.key,
      required this.apiName,
      required this.name,
      required this.rating,
      required this.reviewCount,
      required this.description,
      required this.imageUrl,
      required this.id,
      this.ingredients});

  FavoriteItemsController favoriteItemsController = FavoriteItemsController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
  elevation: 20,
  child: Container(
    height: MediaQuery.of(context).size.height * 0.2,
    width: MediaQuery.of(context).size.width,
    color: Colors.black,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageUrl != ' ' && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: size.width * 0.25,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  salan,
                  width: size.width * 0.25,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 15,
                  ),
                  Text(
                    '(${reviewCount } Reviews)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.35,
                child: Text(
                  description  ,
                  maxLines: 4,
                  
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.016,
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<User?>(
                stream: _auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        if (id.isNotEmpty &&
                            name.isNotEmpty &&
                            rating.isNotEmpty &&
                            reviewCount.isNotEmpty &&
                            description.isNotEmpty &&
                            imageUrl.isNotEmpty &&
                            ingredients != null) {
                          favoriteItemsController.checkFavorite(
                            id,
                            name,
                            rating,
                            reviewCount,
                            description,
                            imageUrl,
                            ingredients!,
                          );
                        }
                      },
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('favorites')
                            .doc(id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Placeholder while loading data
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.hasData && snapshot.data!.exists) {
                            return const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            );
                          }

                          return const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
          // _auth.currentUser == null
          //     ? SizedBox()
          //     : Align(
          //         alignment: Alignment.topRight,
          //         child: GestureDetector(
          //           onTap: () {
          //             if (id != '' && name != '' && rating != '' && reviewCount != '' && description != '' && imageUrl != ''&& ingredients != null) {
          //               favoriteItemsController.checkFavorite(
          //                 id,
          //                 name,
          //                 rating,
          //                 reviewCount,
          //                 description,
          //                 imageUrl,
          //                 ingredients!,
          //               );
          //             }
          //           },
          //           child: StreamBuilder<DocumentSnapshot>(
          //             stream: FirebaseFirestore.instance
          //                 .collection('favorites')
          //                 .doc(id)
          //                 .snapshots(),
          //             builder: (context, snapshot) {
          //               if (snapshot.connectionState == ConnectionState.waiting) {
          //                 return const CircularProgressIndicator(); // Placeholder while loading data
          //               }
          //               if (snapshot.hasError) {
          //                 return Text('Error: ${snapshot.error}');
          //               }

          //               if (snapshot.hasData && snapshot.data!.exists) {
          //                 return const Icon(
          //                   Icons.favorite,
          //                   color: Colors.red,
          //                 );
          //               }

          //               return const Icon(
          //                 Icons.favorite,
          //                 color: Colors.white,
          //               );
          //             },
          //           ),
          //         ),
          //       ),
        ],
      ),
    ),
  ),
);

  }
}
