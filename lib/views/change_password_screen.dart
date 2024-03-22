import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(changePasswordBtn),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Change Passowrd",
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
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              const CustomTextField(
                  labelText: 'Current Password', hintext: 'Current Password'),
              SizedBox(
                height: size.height * 0.05,
              ),
              const CustomTextField(
                  labelText: 'New Password', hintext: 'New Password'),
              SizedBox(
                height: size.height * 0.05,
              ),
              const CustomTextField(
                  labelText: 'Confirm Password', hintext: 'Confirm Password'),
            ],
          ),
        ),
      ),
    );
  }
}