import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/controller/edit_profile_controller/edit_profle_controller.dart';
import 'package:foodfinder/model/user_model.dart';
import 'package:foodfinder/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? userModel;
  const EditProfileScreen({super.key, this.userModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.userModel != null && widget.userModel!.uid != null) {
      editProfileController
          .fetchUserDataAndAssignToControllers(widget.userModel!.uid!);
    }
  }

  EditProfileController editProfileController = EditProfileController();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        editProfileController.image = File(pickedFile.path);
      } else {
        log('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: editProfileController.isUpdating == true
                ? const CircularProgressIndicator(
                    color: Colors.red,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.userModel != null &&
                            widget.userModel!.uid != null &&
                            widget.userModel!.uid!.isNotEmpty &&
                            context != null) {
                          editProfileController.uploadUserDataAndImage(
                              widget.userModel!.uid!, context);
                          setState(() {});
                        } else {
                          
                          Fluttertoast.showToast(
                            msg: "Please log in first !!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Container(
                        width: size.width,
                        height: size.height * 0.065,
                        color: const Color(0xffCA0000),
                        child: Center(
                          child: Text(
                            'Edit Changes',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          color: Colors.black,
                          width: size.width * 0.3,
                          height: size.height * 0.15,
                          child: Stack(
                            children: [
                              if (widget.userModel == null ||
                                  widget.userModel!.profileImage == null)
                                const CircleAvatar(
                                  radius: 50,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                              if (editProfileController.image != null)
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(
                                          editProfileController.image!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if (widget.userModel != null &&
                                  widget.userModel!.profileImage != null)
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.userModel!.profileImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              Positioned(
                                  top: size.height * 0.1,
                                  right: size.width * 0.08,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.black,
                                            title: const Text(
                                              'Choose Image Source',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: const Text(
                                                      'From Gallery'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    getImage(
                                                        ImageSource.camera);
                                                  },
                                                  child:
                                                      const Text('From Camera'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      //
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      CustomTextField(
                          obsecure: false,
                          controller: editProfileController.firstNameController,
                          labelText: 'First Name',
                          hintext: 'First Name'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextField(
                          obsecure: false,
                          controller: editProfileController.lastNameController,
                          labelText: 'Last Name',
                          hintext: 'Last Name'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextField(
                          obsecure: false,
                          controller: editProfileController.emailController,
                          labelText: 'Email',
                          hintext: 'Email'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextField(
                          obsecure: false,
                          controller: editProfileController.phoneController,
                          labelText: 'Phone',
                          hintext: 'Phone'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextField(
                          obsecure: false,
                          controller: editProfileController.cityController,
                          labelText: 'City',
                          hintext: 'City'),
                    ]),
              ),
            )));
  }
}
