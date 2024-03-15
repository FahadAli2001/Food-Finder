import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/upload_image_screen.dart';
import 'package:foodfinder/views/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 4), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context)
      =>const WelcomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
          ),

          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(splashBurger),
              fit: BoxFit.fill)
            ),
          ),

                    Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(blackBg),
              fit: BoxFit.fill)
            ),
          ),
          Positioned(
            top: size.height * 0.6,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Image.asset(welcomeText)
              ],
            ),
          ),
          // Positioned(
          //   top: size.height * 0.84,
          //   left: 15,
          //   right: 15,
          //   child: Column(
          //     children: [
          //       Image.asset(getStartedBtn)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}