import 'package:flutter/material.dart';
import 'package:foodfinder/const/icons.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/map_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(logo),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)
            =>const MapScreen()));
          },
          child: Image.asset(saveRecipeBtn)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(salan),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Chicken Curry",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
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
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "4.5 (189 Reviews)",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Ingredients",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
               const SizedBox(
                height: 10,
              ),
              const Text(
                "Chicken",
                style: TextStyle(
                    color: Colors.white,
                     
                    fontSize: 15.5),
              ),
              const Text(
                "1/2 onion",
                style: TextStyle(
                    color: Colors.white,
                    
                    fontSize: 15.5),
              ),
              const Text(
                "Red Paper",
                style: TextStyle(
                    color: Colors.white,
                     
                    fontSize: 15.5),
              ),
              const Text(
                "Butter",
                style: TextStyle(
                    color: Colors.white,
                    
                    fontSize: 15.5),
              ),
            const  SizedBox(
                height: 15,
              ),
               const Text(
                "Instructions",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
               const  SizedBox(
                height: 15,
              ),
            const  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus et lacus in fringilla. Sed tempus semper turpis, ac malesuada quam proin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus et lacus in fringilla. Sed tempus semper turpis, ac malesuada quam proin luctus. Sed tempus semper turpis, ac malesuada quam proin.",
                 style: TextStyle(
                    color: Colors.white,
                    
                    fontSize: 15),)
            ],
          ),
        ),
      ),
    );
  }
}
