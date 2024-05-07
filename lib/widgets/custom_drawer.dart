import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/change_password_screen.dart';
import 'package:foodfinder/views/home_screen.dart';
import 'package:foodfinder/views/login_screen.dart';
import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/views/saved_items_screen.dart';
 import 'package:foodfinder/views/signup_screen.dart';

import '../controller/auth_controller/login_controller.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  UserModel? userModel;

  CustomDrawer({super.key, this.userModel});
  LoginController loginController = LoginController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.black,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userModel == null || userModel!.profileImage == null
                      ? const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(userModel!.profileImage!))),
                        ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userModel?.fname ?? ''} ${userModel?.lname ?? 'Guest'}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                     
                    ],
                  )
                ],
              ),
              //
              SizedBox(
                height: size.height * 0.05,
              ),
              //
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen(
                                userModel: null,
                              )));
                },
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              //

              _auth.currentUser != null
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                      userModel: userModel,
                                    )));
                      },
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              //

              _auth.currentUser != null
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SavedItemsScreen()));
                      },
                      leading: const Icon(
                        Icons.laptop,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        "Saved Recipes",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),

              // _auth.currentUser != null
              //     ? ListTile(
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       const SharedRecipeScreen()));
              //         },
              //         leading: const Icon(
              //           Icons.share,
              //           color: Colors.white,
              //           size: 30,
              //         ),
              //         title: const Text(
              //           "Shared Recipes",
              //           style: TextStyle(
              //               color: Colors.white, fontWeight: FontWeight.bold),
              //         ),
              //       )
              //     : Container(),
              //

              _auth.currentUser != null
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordScreen()));
                      },
                      leading: const Icon(
                        Icons.key,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: const Text(
                        "Change Passowrd",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),

              const Spacer(),
              _auth.currentUser != null
                  ? GestureDetector(
                    onTap: () {
                      _auth.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const 
                        LoginScreen()), (route) => false);
                      });
                    },
                    child: Container(
                        width: size.width,
                        height: size.height * 0.05,
                        color:const Color(0xffCA0000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Log out',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02),
                            ),
                          ],
                        )),
                  )
                  : Column(
                    children: [
                      Container(
                          width: size.width,
                          height: size.height * 0.05,
                          color:const Color(0xffCA0000),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.02),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                           Container(
                          width: size.width,
                          height: size.height * 0.05,
                          color:const Color(0xffCA0000),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()));
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.02),
                              ),
                            ),
                          )),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
