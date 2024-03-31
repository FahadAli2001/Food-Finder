 
import 'package:flutter/material.dart';
import 'package:foodfinder/model/user_model.dart';
 import 'package:foodfinder/views/profile_screen.dart';
import 'package:foodfinder/views/upload_image_screen.dart';
import 'package:foodfinder/widgets/custom_drawer.dart';

import '../const/images.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeScreen({super.key,   this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    
    super.initState();
   
  }

   
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
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ProfileScreen(
                          userModel: widget.userModel,
                        )));
              },
              child:   widget.userModel!.profileImage != null
                      ? Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(widget.userModel!.profileImage!))),
                        )
                      : const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        drawer:   CustomDrawer(
          userModel: widget.userModel,
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search Here",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadImageScreen()));
                  },
                  child: Image.asset(
                    uploadbtn,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Most Popular Recipes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  height: size.height * 0.46,
                  child: GridView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: size.height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              salan,
                              height: size.height * 0.13,
                              fit: BoxFit.fill,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Salan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                    child: Container(
                                  padding: EdgeInsets.all(3),
                                  color: Colors.red,
                                  child: const Text(
                                    'view detail',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Just For You',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025),
                    ),
                    //
                    Text(
                      'view all',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.02),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: size.height * 0.03,
                ),
                Card(
                  elevation: 20,
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            salan,
                            width: 100,
                            height: size.height,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Chicken Curry',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.025),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                  Text(
                                    ' 4.5 (180 Review)',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.016),
                                  ),
                                ],
                              ),
                              Text(
                                  'Lorem ipsum dolor sit amet, \n consectetur adipiscing elit ...',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.016,
                                  )),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
