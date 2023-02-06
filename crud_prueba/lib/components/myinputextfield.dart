import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTextFields extends StatelessWidget {
   MyTextFields({super.key, required this.hintedtext, 
   required this.labeltext,
   required this.Inputcontroller});

  final String hintedtext;
  final String labeltext;
  final TextEditingController Inputcontroller;
  

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: Inputcontroller,
              validator: (value){
                if(value!.isEmpty){
                  return "$labeltext is required";
                }


              },
              decoration: InputDecoration(
                hintText: hintedtext,
                labelText: labeltext,
                enabledBorder: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
                focusedBorder: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
                errorBorder: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder( borderSide: BorderSide(width: 3, color: Colors.red)),
              ),
            ),
          );
  }
}