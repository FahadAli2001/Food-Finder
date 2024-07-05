import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/favorite_items_controller/favorite_items_controller.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/map_screen.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final UserModel? user;
  // ignore: prefer_typing_uninitialized_variables
  var apiData;
  // ignore: prefer_typing_uninitialized_variables
  var recipe;
  var recipeId;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  DetailScreen(
      {super.key,
      this.apiData,
      this.image,
      this.recipe,
      this.recipeId,
      this.user});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FavoriteItemsController favoriteItemsController = FavoriteItemsController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final uuid = Uuid();

  Future<void> updateRating(String recipeId, String ratingType) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Fluttertoast.showToast(
          msg: "Login First",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffCA0000),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      DocumentReference recipeRef =
          FirebaseFirestore.instance.collection('recipes').doc(recipeId);
      DocumentSnapshot recipeSnapshot = await recipeRef.get();

      if (recipeSnapshot.exists) {
        Map<String, dynamic> data =
            recipeSnapshot.data() as Map<String, dynamic>;
        String ratingsString = data['reviewCount'] ?? '0';
        int thumbsCount = int.tryParse(ratingsString) ?? 0;

        if (ratingType == 'thumbsUp') {
          thumbsCount++;
          Fluttertoast.showToast(
            msg: "Thanks for your review!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (ratingType == 'thumbsDown') {
          thumbsCount--;
          Fluttertoast.showToast(
            msg: "Thanks for your review!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        await recipeRef.update({
          'reviewCount': thumbsCount.toString(),
        });
      } else {
        // Handle the case where the recipe doesn't exist
        Fluttertoast.showToast(
          msg: "Recipe not found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffCA0000),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Handle errors
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffCA0000),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              userModel: widget.user,
                            )));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
          elevation: 0,
          title: 
           Image.asset(
            logo,
            width: size.width * 0.5,
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              try {
                if (widget.apiData != null &&
                    widget.apiData!.containsKey('recipe_details') &&
                    widget.apiData!["recipe_details"] is List &&
                    widget.apiData!["recipe_details"].isNotEmpty &&
                    widget.apiData!["recipe_details"][0].containsKey('title') &&
                    widget.apiData!["recipe_details"][0]['title'].isNotEmpty) {
                  checkAndNavigate(
                      widget.apiData!["recipe_details"][0]['title']);
                } else if (widget.recipe != null &&
                    widget.recipe!.containsKey('title') &&
                    widget.recipe!['title'].isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        keyword: widget.recipe!['title'],
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Something went wrong",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: const Color(0xffCA0000),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "An error occurred: ${e.toString()}",
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
                        ? widget.apiData["recipe_details"][0]['title']
                                .replaceAll('_', ' ') ??
                            ''
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
                              widget.recipeId ?? widget.apiData["recipe_details"][0]['title'],
                              widget.apiData != null
                                  ? widget.apiData["recipe_details"][0]['title']
                                      .replaceAll('_', ' ')
                                  : widget.recipe?['title'],
                              widget.apiData != null
                                  ? widget.apiData['ratings'] ?? '4'
                                  : widget.recipe?['ratings'],
                              widget.apiData != null
                                  ? widget.apiData['reviewCount'] ?? "N/A"
                                  : widget.recipe?['reviewCount'],
                              widget.apiData != null
                                  ? widget.apiData["recipe_details"][0]
                                      ['instructions']
                                  : widget.recipe?['instructions'],
                              widget.apiData != null
                                  ? widget.image
                                  : widget.recipe?['imageUrl'],
                              widget.apiData != null
                                  ? widget.apiData["recipe_details"]
                                  : widget.recipe?['ingredients'],
                              widget.apiData != null
                                  ? widget.apiData["recipe_details"][0]['title']
                                  : widget.recipe['apiName'],
                            );
                          },
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('favorites')
                                .doc(widget.recipeId ?? widget.apiData["recipe_details"][0]['title'] )
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
                          updateRating(widget.recipeId, 'thumbsUp');
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
                          updateRating(widget.recipeId, 'thumbsDown');
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
