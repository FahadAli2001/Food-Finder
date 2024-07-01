import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfinder/views/detail_screen.dart';
import 'package:http/http.dart' as http;

class UploadImageController extends ChangeNotifier {
  bool isSearching = false;
  File? image;
  // ignore: prefer_typing_uninitialized_variables
  var _apiResData;

  // ignore: unnecessary_getters_setters
  get apiResData => _apiResData;

  set apiResData(value) {
    _apiResData = value;
  }

  Future<void> sendImageToAPI(context) async {
    isSearching = true;
    notifyListeners();
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
        if (apiResData['error'] == "Please Insert Correct Image") {
          isSearching = false;
          notifyListeners();
          Fluttertoast.showToast(
              msg: 'Please Upload Correct Image',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
              Navigator.pop(context);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        apiData: apiResData,
                        image: image,
                      )));
        }
      } else {
        isSearching = false;
        notifyListeners();
        log(apiResData);
        log('Failed to send image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      isSearching = false;
      notifyListeners();
      log('Error sending image: $error');

      // Handle the error
    }
  }
}
