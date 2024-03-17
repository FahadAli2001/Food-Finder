import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/views/change_password_screen.dart';
import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/views/saved_items_screen.dart';
import 'package:foodfinder/views/shared_recipe_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hamza Riaz",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
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
                          builder: (context) => const ProfileScreen()));
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
                onTap:() {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SharedRecipeScreen()));
                },
                leading: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  "Total Recipes Share",
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
                  Icons.password,
                  color: Colors.white,
                  size: 30,
                ),
                title: const Text(
                  "Change Passowrd",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.25,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    logoutBtn,
                    height: 70,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
