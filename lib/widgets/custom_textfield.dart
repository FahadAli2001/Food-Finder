import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintext;
  final String labelText;
  const CustomTextField({super.key,required this.labelText,required this.hintext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintext,
        hintStyle:const TextStyle(color: Colors.white),
        labelText: labelText,
        labelStyle:const TextStyle(color: Colors.white),
        border:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
           
          )
        ),
        focusColor: Colors.white,
        focusedBorder:const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          
          )
        ),
        enabledBorder:const OutlineInputBorder(
           borderSide: BorderSide(
            color: Colors.white,
          
          )
        )
      ),
    );
  }
}