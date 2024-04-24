import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/auth_controller/login_controller.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/signup_screen.dart';
import 'package:foodfinder/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final loginController = Provider.of<LoginController>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //         ))),
                SizedBox(
                  height: size.height * 0.09,
                ),
                Image.asset(
                  logo,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: size.height * 0.09,
                ),
                CustomTextField(
                    controller: loginController.emailController,
                    obsecure: false,
                    labelText: 'Email',
                    hintext: 'Email'),
                SizedBox(
                  height: size.height * 0.05,
                ),
                CustomTextField(
                    controller: loginController.passwordController,
                    obsecure: true,
                    labelText: 'Password',
                    hintext: 'Password'),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: const Color(0xffCA0000),
                      activeColor: Colors.white,
                      value: loginController.rememberMe,
                      onChanged: (bool? value) {
                        // log(loginController.rememberMe.toString());
                        setState(() {
                          loginController.rememberMe = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(color: Color(0xffCA0000)),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(userModel: null),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: size.width,
                    height: size.height * 0.06,
                    color: const Color(0xffCA0000),
                    child: Center(
                      child: Text(
                        'Continue As Guest ',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                loginController.islogingIn == false
                    ? GestureDetector(
                        onTap: () {
                          loginController.checkIsRememberMe(context);
                          setState(() {});
                        },
                        child: Container(
                    width: size.width,
                    height: size.height * 0.06,
                    color: const Color(0xffCA0000),
                    child: Center(
                      child: Text(
                        'Sign In ',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),)
                    : const CircularProgressIndicator(
                        color: Color(0xffCA0000),
                      ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                  },
                  child: const Text(
                    "Don't have an account ? Create a new one",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
