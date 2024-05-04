import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodfinder/views/detail_screen.dart';
import 'package:http/http.dart' as http;

class UploadImageController {
  File? image;
  // ignore: prefer_typing_uninitialized_variables
  var _apiResData;

  // ignore: unnecessary_getters_setters
  get apiResData => _apiResData;

  set apiResData(value) {
    _apiResData = value;
  }

  Future<void> sendImageToAPI(context) async {
    log("send image $image");
    var uri = Uri.parse('http://3.111.15.46:5000/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        log('Image successfully sent to the API');
        var jsonRes = await response.stream.bytesToString();
        apiResData = jsonDecode(jsonRes);
        log(apiResData.toString());
        // log(apiResData["predicted_title"]);
        // log(apiResData['recipe_details'][0]['ingredients']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      apiData: apiResData,
                      image: image,
                    )));
      } else {
        log(apiResData);
        log('Failed to send image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error sending image: $error');
      // Handle the error
    }
  }
}
