import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodfinder/views/detail_screen.dart';
import 'package:http/http.dart' as http;
class UploadImageController{
  File? image;
  var apiResData;
  
    Future<void> sendImageToAPI(context) async {
    var uri = Uri.parse('https://m966bfcp-5000.asse.devtunnels.ms/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        log('Image successfully sent to the API');
       var jsonRes =  await response.stream.bytesToString();
      apiResData = jsonDecode(jsonRes);
      // log(apiResData["predicted_title"]);
      // log(apiResData['recipe_details'][0]['ingredients']);
       Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>  DetailScreen(
                      apiData: apiResData,
                      image: image,
                    )));
      } else {
        log('Failed to send image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error sending image: $error');
      // Handle the error
    }
  }
}