import 'package:flutter/material.dart';

Widget buildImageContainer(
  Color color,
  String title,
  String subtitle,
  String imagePath,
){
  return Container(
    color: color,
    child: Padding(
      padding: EdgeInsets.symmetric(
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo Image at the Top
          Padding(
            padding: const EdgeInsets.only(top: 55), 
            child: SizedBox(
              width:  200, 
              height:  80, 
              child: Image.asset(
                'assets/images/carro_wedding_logo.png', 
              ),
            ),
          ),
          SizedBox(height: 20), // Spacing between logo and image

          // Main Image with Controlled Size
          Flexible(
            flex: 3,
            child: SizedBox(
              width:  500 , 
              height: 300 , 
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Title Text
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),

          // Subtitle Text
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    ),
  );
}