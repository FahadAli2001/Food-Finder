import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/const/icons.dart';
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
          title: Image.asset(logo),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MapScreen()));
              },
              child: Image.asset(saveRecipeBtn)),
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
                      fit: BoxFit.fill,
                      width: size.width,
                      height: size.height * 0.3,
                    ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.apiData != null
                        ? widget.apiData['predicted_title']
                        : widget.recipe?['title'] ?? 'Default Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
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
                        ),
                        const SizedBox(width: 15),
                        Image.asset(linkIcon),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
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
                      widget.apiData["recipe_details"][0]['ingredients'],
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
                          widget.recipe?['ingredients'][index] ?? '',
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
            ],
          )),
        ));
  }
}
