import 'package:extra_mile/ReusableCode/AppStyles.dart';
import 'package:flutter/material.dart' show Alignment, AssetImage, BlurStyle, Border, BorderRadius, BoxDecoration, BoxFit, BoxShadow, BuildContext, Colors, Container, DecorationImage, Key, MediaQuery, StatelessWidget, Widget;

class Box extends StatelessWidget {
  final String imgPath;

  const Box({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50.0),
        color: AppStyles.GrayC,
        image: DecorationImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          image: AssetImage("assets/images/$imgPath"),
        ),
        border: Border.all(width: 6, color: AppStyles.Black1C),
        boxShadow:  [
          BoxShadow(
            color: AppStyles.TealC,
            blurRadius: 20,
            spreadRadius: 2,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
    );
  }
}
