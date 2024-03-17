import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintext;
  final String labelText;
  const CustomTextField({super.key,required this.labelText,required this.hintext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.06,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintext,
          hintStyle:const TextStyle(color: Colors.white70),
          labelText: labelText,
          labelStyle:const TextStyle(color: Colors.white70),
          border:const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
             
            )
          ),
          focusColor: Colors.white70,
          focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white70,
            
            )
          ),
          enabledBorder:const OutlineInputBorder(
             borderSide: BorderSide(
              color: Colors.white70,
            
            )
          )
        ),
      ),
    );
  }
}