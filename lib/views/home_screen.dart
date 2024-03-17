import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/widgets/custom_drawer.dart';

import '../const/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
          title: Image.asset(logo),
          centerTitle: true,
          actions:  [
            
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                =>const ProfileScreen()));
              },
              child:const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
              ),
            ),
         const   SizedBox(
              width: 15,
            )
          ],
        ),
        drawer:const CustomDrawer()
      ),
    );
  }
}
