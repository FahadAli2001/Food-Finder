import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfinder/const/images.dart';

import '../controller/auth_controller/signup_controller.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  SignupController signupcontroller = SignupController();
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
                  height: size.height * 0.01,
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
                  height: size.height * 0.03,
                ),
                Image.asset(
                  logo,
                  height: 70,
                  width: 200,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                 CustomTextField(
                  obsecure: false,
                  controller: signupcontroller.firstNameController,
                  labelText: 'First Name', hintext: 'First Name'),
                SizedBox(
                  height: size.height * 0.02,
                ),
                  CustomTextField(
                    obsecure: false,
                     controller: signupcontroller.lastNameController,
                    labelText: 'Last Name', hintext: 'Last Name'),
                                    SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextField(
                  obsecure: false,
                   controller: signupcontroller.emailController,
                  labelText: 'Email', hintext: 'Email'),
                SizedBox(
                  height: size.height * 0.02,
                ),
                  CustomTextField(
                    obsecure: true,
                     controller: signupcontroller.passwordController,
                    labelText: 'Password', hintext: 'Password'),
                     SizedBox(
                  height: size.height * 0.02,
                ),
                  CustomTextField( 
                    obsecure: true,
                     controller: signupcontroller.cPasswordController,
                    labelText: 'Confirm Password', hintext: 'Confirm Password'),
                       SizedBox(
                  height: size.height * 0.02,
                ),

                signupcontroller.isSigningUp == true ?
                const CircularProgressIndicator(
                  color: Colors.red,
                ):
                GestureDetector(
                  onTap: () {
                    signupcontroller.checkAllFieldsAreFilled(context);
                    setState(() {
                      
                    });
                  },
                  child: Image.asset(signupBtn))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
