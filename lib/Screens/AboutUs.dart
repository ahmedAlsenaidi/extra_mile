import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Data/BranchModel.dart';
import '../ReusableCode/Helper.dart';
import '../Data/DatabaseHelper.dart';
import '../Screens/Details.dart'; // Make sure this import is correct
import '../Screens/Map.dart'; // Assuming this is the correct import for your Map screen
import '../main.dart'; // Assuming this is the correct import for your main.dart file
import 'package:gap/gap.dart'; // Assuming this is the correct import for the Gap package

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Text("Contact Us"),
            Positioned(
              // bottom: 10,
              // left: 140,
              child: IconButton(
                icon: const Icon(
                  Icons.sms,
                  color: Colors.black,
                ),
                onPressed: () {
                  Helper.sendSMS(
                    '96313502',
                    "Hi i like", //'${branch.branchData!.name} branch'
                    context,
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              child: IconButton(
                icon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                onPressed: () {
                  Helper.sendEmail(
                    's129108@student.squ.edu.om',
                    'branch info',
                    "Hi i like branch give me more information", //'${branch.branchData!.name}
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
