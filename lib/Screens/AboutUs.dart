import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ReusableCode/Helper.dart';
import '../ReusableCode/AppStyles.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  double initialRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchUserRating();
  }

  Future<void> fetchUserRating() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        double? userRating = userDoc.data()?['rating'] as double?;
        if (userRating != null) {
          setState(() {
            initialRating = userRating;
          });
        }
      }
    } catch (e) {
      print('Error fetching user rating: $e');
    }
  }

  Future<void> _submitRating(double rating) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'rating': rating,
        });
      }
    } catch (e) {
      print('Error submitting rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("About Us", style: AppStyles.Gray)),
        backgroundColor: AppStyles.Black1C,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Us",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppStyles.Black1C,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to Extra Mile, where convenience meets automotive care! We specialize in providing a seamless car service appointment experience, designed to make your life easier.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 20),
            Text(
              "Our Mission",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppStyles.Black1C,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "At Extra Mile, our mission is to revolutionize the way you take care of your vehicle. We understand that scheduling car services can be time-consuming and frustrating. That's why we've developed a user-friendly platform that allows you to book appointments with ease, anytime, anywhere.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 20),
            Text(
              "Our Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppStyles.Black1C,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Convenient Appointment Booking: With just a few taps, you can schedule your car service appointments at your preferred date and time.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 20),
            Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppStyles.Black1C,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Behind Extra Mile is a dedicated team of automotive enthusiasts who are passionate about delivering top-notch service. Here's a glimpse of our talented team:",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 10),
            Text(
              "1. Ahmed Al-Senaidi",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "2. Al-Salt Al-Naabi",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "3. Mohammed AL-Harrasi",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "4. Usama Al-busidi",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "5. Ya'Rab Al-Maimari",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 20),
            Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppStyles.Black1C,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Ready to experience hassle-free car service appointments? Download Extra Mile and join thousands of satisfied customers who trust us with their automotive needs.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Contact Us:",
                  style: TextStyle(
                      color: AppStyles.Black1C,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const Text("SMS:"),
                IconButton(
                  icon: Icon(
                    Icons.sms,
                    color: AppStyles.Black1C,
                  ),
                  onPressed: () {
                    Helper.sendSMS(
                      '96313502',
                      "Hi i like",
                      context,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("E-mail:"),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    color: AppStyles.Black1C,
                  ),
                  onPressed: () {
                    Helper.sendEmail(
                      's129108@student.squ.edu.om',
                      'branch info',
                      "Hi i like branch give me more information",
                      context,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Rate our app:',
              style: TextStyle(fontSize: 20),
            ),
            RatingBar.builder(
              initialRating: initialRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _submitRating(rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
