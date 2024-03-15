import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const  EdgeInsets.all(30),
          child: Column(
            
            children:[
              SizedBox(
                height: size.height*0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:const Align(
                  alignment: Alignment.topLeft,
                  child:   Icon(Icons.arrow_back_ios,color: Colors.white,))),
                  SizedBox(height: size.height*0.25,),
                Image.asset(logo,height: 70,width: 200,fit: BoxFit.fill,),
                SizedBox(height: size.height*0.09,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>const LoginScreen()));
                  },
                  child: Image.asset(loginBtn)),
                SizedBox(height: size.height*0.3,),
              const  Align(
                  alignment: Alignment.bottomRight,
                  child: Text("Skip -->",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),),
                )
            ]
          ),
        ),
      ),
    );
  }
}