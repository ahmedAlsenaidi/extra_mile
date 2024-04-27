import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppStyles{

  static TextStyle headlineStyle1 = const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle headlineStyle2 = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white);//Color.fromRGBO(81, 130, 155,100)//rgb(81, 130, 155));//rgb(81, 130, 155)
  static TextStyle headlineStyle3= const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
  //Colors
  static TextStyle Black1 = GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xFF222831)));
  static TextStyle Black2 = GoogleFonts.roboto(textStyle:  TextStyle(color: Color(0xFF31363F)));
  static TextStyle Teal = GoogleFonts.roboto(textStyle:  TextStyle(color: Color(0xFF76ABAE)));
  static TextStyle Gray = GoogleFonts.roboto(textStyle:  TextStyle(color: Color(0xFFEEEEEE)));

  static Color Black1C = Color(0xFF222831);
  static Color Black2C = Color(0xFF31363F);
  static Color TealC = Color(0xFF76ABAE);
  static Color GrayC = Color(0xFFEEEEEE);

}