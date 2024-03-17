import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: size.width,
            height: size.height * 0.065,
            color: const Color(0xffCA0000),
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
                  'Log Out',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Hamza Riaz',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.w500),
              ),
              //  SizedBox(
              //   height: size.height * 0.01,
              // ),
              Text(
                'Food Lover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '59',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text(
                        'Recipes Shared',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '08',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text(
                        'Saved Recipe',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                width: size.width,
                height: size.height * 0.065,
                color: const Color(0xffCA0000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Saved Items',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: size.width,
                child:const Divider(
                  thickness: 0.3,
                  color: Colors.white,
                ),
              ),
               SizedBox(
                height: size.height * 0.02,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Shared Recipes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: size.width,
                child:const Divider(
                  thickness: 0.3,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
