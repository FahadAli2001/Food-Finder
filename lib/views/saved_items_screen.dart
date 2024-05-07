import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/detail_screen.dart';
import 'package:foodfinder/views/home_screen.dart';
 import 'package:foodfinder/widgets/widget_recipe_card.dart';

class SavedItemsScreen extends StatefulWidget {
  final UserModel userModel;
  const SavedItemsScreen({super.key,required this.userModel});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Saved Items",
            style: TextStyle(
              color: Colors.white,
              //  fontWeight: FontWeight.bold
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)
                 =>HomeScreen(
                  userModel:widget.userModel ,
                 )));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                recipe: data,
                                recipeId: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                         
                        },
                        child: RecipeCard(
                          id: snapshot.data!.docs[index].id,
                          name: data['title'],
                          rating: data['rating'],
                          reviewCount: data['reviewCount'],
                          description: data['instructions'],
                          imageUrl: data['imageUrl'],
                          ingredients: data['ingredients'],
                        ),
                      );
                    },
                  );
                }
                else {
                  return const Center(child:   Text('No Data',style: TextStyle(color: Colors.white),));
                }
              })
        ),
      ),
    );
  }
}
