import 'package:flutter/material.dart';
 import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/views/change_password_screen.dart';
import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/views/saved_items_screen.dart';
import 'package:foodfinder/views/shared_recipe_screen.dart';

import '../controller/auth_controller/login_controller.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  UserModel? userModel;

  CustomDrawer({super.key, this.userModel});
  LoginController loginController = LoginController();

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
                      const Text(
                        "Food Lover",
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
              const ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              //

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   ProfileScreen(
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
              ),
              //

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SavedItemsScreen()));
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
              ),

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SharedRecipeScreen()));
                },
                leading: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 30,
                ),
                title: const Text(
                  "Shared Recipes",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              //

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()));
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
              ),

              // Expanded(
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: GestureDetector(
              //         onTap: () {
              //           loginController.signOut(context);
              //         },
              //         child: Image.asset(
              //           logoutBtn,
              //           height: 70,
              //         ),
              //       )),
              // )
            const  Spacer(),
              Container(
                width: size.width,
                height: size.height * 0.05,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const  Icon(Icons.logout,color: Colors.white,),
                     SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text('Log out',style: TextStyle(color: Colors.white,fontSize: size.height * 0.02),),
                
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
