import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/detail_screen.dart';
import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/views/upload_image_screen.dart';
import 'package:foodfinder/widgets/custom_drawer.dart';
import 'package:foodfinder/widgets/widget_recipe_card.dart';
import '../const/images.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeScreen({super.key, this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _searchController = TextEditingController();

  late String _searchTerm;
  late Stream<QuerySnapshot> stream;

  @override
  void initState() {
    super.initState();
    _searchTerm = '';
  }

  void onSearchChanged(String value) {
    setState(() {
      _searchTerm = value.toLowerCase();
      stream = FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isEqualTo: _searchTerm)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
          title: Image.asset(
            logo,
            width: size.width * 0.5,
          ),
          centerTitle: true,
          actions: [
            _auth.currentUser != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    userModel: widget.userModel,
                                  )));
                    },
                    child: widget.userModel == null ||
                            widget.userModel!.profileImage == null
                        ? const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          )
                        : Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.userModel!.profileImage!),
                              ),
                            ),
                          ),
                  )
                : Container(),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        drawer: CustomDrawer(
          userModel: widget.userModel,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  onSearchChanged(value);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search Here",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadImageScreen()));
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.07,
                  color: const Color(0xffCA0000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        'Upload ',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _searchTerm != ''
                  ? Expanded(
                      child: StreamBuilder(
                        stream: stream,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }else if(
                            snapshot.data!.docs.isEmpty
                          ){
                            return Center(
                              child: Text('No Recipe Found !',
                              style: TextStyle(color: Colors.white60),),
                            );
                          } else {
                           
                            log('Query results: ${snapshot.data!.docs}');
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
                                          recipeId:
                                              snapshot.data!.docs[index].id,
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
                        },
                      ),
                    )
                  : Expanded(
                    
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.025),
                              ),
                            ],
                          ),
                          //
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Expanded(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('recipes')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
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
                                                builder: (context) =>
                                                    DetailScreen(
                                                  recipe: data,
                                                  recipeId: snapshot
                                                      .data!.docs[index].id,
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
                                }),
                          )
                        ],
                      ),
                    )
            ])),
      ),
    );
  }
}
