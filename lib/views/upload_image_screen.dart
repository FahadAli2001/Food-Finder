import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:foodfinder/controller/upload_image_controller/upload_image_controller.dart';
 import 'package:image_picker/image_picker.dart';

 class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
    UploadImageController uploadImageController = UploadImageController();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
       uploadImageController.image = File(pickedFile.path);
       uploadImageController.sendImageToAPI(context);
      } else {
        log('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(logo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          uploadImageController.image == null ?  Image.asset(uploadImage):Image.file(uploadImageController.image!),
          const  SizedBox(
              height: 70,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                   getImage(ImageSource.camera);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)
                    // =>const DetailScreen()));
                  },
                  child: Image.asset(captureImageBtn)),
                 const  SizedBox(
              width: 15,
            ),
                GestureDetector(
                  onTap: () {
                     getImage(
                      ImageSource.gallery
                     );
                  },
                  child: Image.asset(browseFileBtn))
              ],
            )
          ],
        ),
      ),
    );
  }
}