import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
          ),
          Image.asset(map,height: size.height*0.9,),
          Positioned(
            top: 55,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(blackBackBtn))),
          Positioned(
            top: size.height*0.55,
            child: Container(
              width: size.width,
              height: size.height*0.45,
              decoration:const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                    "Nearby Restaurants",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Image.asset(restaurants),
                        );
                      },
                    ),
                  )
                  ],
                ),
              ),
          
            ),
          )
        ],
      ),
    );
  }
}