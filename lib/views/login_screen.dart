import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/signup_screen.dart';
import 'package:foodfinder/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ))),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Image.asset(
                  logo,
                  height: 70,
                  width: 200,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: size.height * 0.09,
                ),
                const CustomTextField(labelText: 'Email', hintext: 'Email'),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const CustomTextField(
                    labelText: 'Password', hintext: 'Password'),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        checkColor: Colors.red,
                        value: true,
                        onChanged: (val) {}),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                 SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>const HomeScreen()));
                  },
                  child: Image.asset(loginBtn)),
                 SizedBox(
                  height: size.height * 0.02,
                ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  =>const SignupScreen()));
                },
                child: const  Text("Don't have an account ? Create a new one",
                  style: TextStyle(
                    color: Colors.white
                  ),),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
