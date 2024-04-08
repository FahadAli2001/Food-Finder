import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/auth_controller/login_controller.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController = LoginController();
  @override
  void initState() {
    super.initState();
    checkRoute(context);
    //  Timer(const Duration(seconds: 5), () {
    //         Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const WelcomeScreen(),
    //           ),
    //         );
    //       });
  }

  void checkRoute(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? rememberMe = sp.getBool('rememberMe');
    log(rememberMe.toString());
    String? uid = sp.getString('uid');
    try {
      if (rememberMe == true) {
        if (uid != null) {
          UserModel? userModel = await loginController.fetchUserData(uid);
          if (userModel != null) {
            Timer(const Duration(seconds: 5), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    userModel: userModel,
                  ),
                ),
                (route) => false,
              );
            });
          } else {
            Timer(const Duration(seconds:4), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            });
          }
        } else {
          // uid is null
          Timer(const Duration(seconds: 4), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          });
        }
      } else {
        Timer(const Duration(seconds: 4), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        });
      }
    } catch (e) {
      log(e.toString());
    }
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
                image: DecorationImage(
                    image: AssetImage(splashBurger), 
                    fit: BoxFit.fill
                    )),
          ),

          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(blackBg), 
                    fit: BoxFit.fill
                    )),
          ),
          Positioned(
            top: size.height * 0.6,
            left: size.width*0.04,
            right: size.width*0.04,
            child: Image.asset(welcomeText),
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
