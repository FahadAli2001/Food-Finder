import 'package:flutter/material.dart';
import 'package:foodfinder/const/icons.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/map_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var apiData;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  DetailScreen({super.key, required this.apiData, required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
              //Image.asset(salan),
              Image.file(
                widget.image!,
                fit: BoxFit.fill,
                width: size.width,
                height: size.height * 0.3,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.apiData['predicted_title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(linkIcon),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // const Row(
              //   children: [
              //     Icon(
              //       Icons.star,
              //       color: Colors.yellow,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Text(
              //       "4.5 (189 Reviews)",
              //       style: TextStyle(color: Colors.white, fontSize: 14),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              const Text(
                "Ingredients",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.apiData["recipe_details"][0]['ingredients'],
                style: const TextStyle(color: Colors.white, fontSize: 15.5),
              ),

              const SizedBox(
                height: 15,
              ),
              const Text(
                "Instructions",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.apiData["recipe_details"][0]['instructions'],
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
