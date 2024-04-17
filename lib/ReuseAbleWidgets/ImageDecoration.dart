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
        color: Colors.amber,
        image: DecorationImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          image: AssetImage("assets/images/$imgPath"),
        ),
        border: Border.all(width: 6, color: Colors.grey),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            spreadRadius: 4.5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
    );
  }
}
