import 'package:flutter/material.dart';
import '../ReuseAbleWidgets/ImageDecoration.dart';
class StaticImgList extends StatelessWidget {
  const StaticImgList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(

        child: SingleChildScrollView(

          scrollDirection: Axis.vertical,
          child: Column(
            // children: [
            //   Box(imgPath: "pic_1.jpg"),
            //   Box(imgPath: "pic_2.jpg"),
            //   Box(imgPath: "pic_3.jpg"),
            //   Box(imgPath: "pic_1.jpg"),
            //   Box(imgPath: "pic_2.jpg"),
            //   Box(imgPath: "pic_3.jpg"),

            // ],
          ),
        ),
      ),
    );
  }
}
