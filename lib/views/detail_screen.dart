import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/favorite_items_controller/favorite_items_controller.dart';
import 'package:foodfinder/views/map_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var apiData;
  // ignore: prefer_typing_uninitialized_variables
  var recipe;
  var recipeId;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  DetailScreen(
      {super.key, this.apiData, this.image, this.recipe, this.recipeId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FavoriteItemsController favoriteItemsController = FavoriteItemsController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkAndNavigate(String title) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('apiName', isEqualTo: title)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(
              keyword: querySnapshot.docs.first['title'],
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Recipe not found in Firebase",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffCA0000),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffCA0000),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
          elevation: 0,
          title: Image.asset(
            logo,
            width: size.width * 0.5,
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              if (widget.apiData != null &&
                  widget.apiData.containsKey('title') &&
                  widget.apiData["recipe_details"][0]['title'] != '') {
                checkAndNavigate(widget.apiData["recipe_details"][0]['title']);
              } else if (widget.recipe != null &&
                  widget.recipe['title'] != '') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      keyword: widget.recipe['title'],
                    ),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Some thing went erong",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: const Color(0xffCA0000),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: Container(
              width: size.width,
              height: size.height * 0.065,
              color: const Color(0xffCA0000),
              child: Center(
                child: Text(
                  'Locate',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.image == null
                  ? Image.network(
                      widget.recipe!['imageUrl'],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      width: size.width,
                      height: size.height * 0.3,
                    )
                  : Image.file(
                      widget.image!,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height * 0.3,
                    ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.apiData != null
                        ? widget.apiData["recipe_details"][0]['title'] ?? ''
                        : widget.recipe?['title'] ?? 'Default Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  _auth.currentUser != null
                      ? GestureDetector(
                          onTap: () {
                            favoriteItemsController.checkFavorite(
                              widget.recipeId,
                              widget.apiData != null
                                  ? widget.apiData['name']
                                  : widget.recipe?['title'],
                              widget.apiData != null
                                  ? widget.apiData['rating']
                                  : widget.recipe?['rating'],
                              widget.apiData != null
                                  ? widget.apiData['reviewCount']
                                  : widget.recipe?['reviewCount'],
                              widget.apiData != null
                                  ? widget.apiData['description']
                                  : widget.recipe?['instructions'],
                              widget.apiData != null
                                  ? widget.apiData['imageUrl']
                                  : widget.recipe?['imageUrl'],
                              widget.apiData != null
                                  ? widget.apiData['ingredients']
                                  : widget.recipe?['ingredients'],
                            );
                          },
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('favorites')
                                .doc(widget.recipeId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
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
                                Icons.favorite,
                                color: Colors.white,
                              );
                            },
                          ),
                        )
                      : SizedBox()
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Ingredients",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 10),
              widget.apiData != null
                  ? Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      '• ' + widget.apiData["recipe_details"][0]['ingredients'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.recipe['ingredients'].length,
                      itemBuilder: (context, index) {
                        return Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          '• ' + widget.recipe?['ingredients'][index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 15),
              const Text(
                "Instructions",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.apiData != null
                    ? widget.apiData["recipe_details"][0]['instructions']
                    : widget.recipe?['instructions'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (_auth.currentUser == null) {
                          Fluttertoast.showToast(
                            msg: "Login First",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xffCA0000),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Thank For Review",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Container(
                        height: size.height * 0.06,
                        decoration:
                            BoxDecoration(color: const Color(0xffCA0000)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Useful ',
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (_auth.currentUser == null) {
                          Fluttertoast.showToast(
                            msg: "Login First",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xffCA0000),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Thank For Review",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Container(
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not Useful ',
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.thumb_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
