import 'package:flutter/material.dart';
import 'package:foodfinder/widgets/custom_shared_recipe_screen.dart';

class SharedRecipeScreen extends StatefulWidget {
  const SharedRecipeScreen({super.key});

  @override
  State<SharedRecipeScreen> createState() => _SharedRecipeScreenState();
}

class _SharedRecipeScreenState extends State<SharedRecipeScreen> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Shared Recipe",
            style: TextStyle(
              color: Colors.white,
              //  fontWeight: FontWeight.bold
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              for (var i = 0; i < 4; i++) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CustomSharedRecipeScreen(),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}