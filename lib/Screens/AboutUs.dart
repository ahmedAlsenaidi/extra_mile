import 'package:extra_mile/ReusableCode/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ReusableCode/Helper.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("About Us",style: AppStyles.Gray,)),
      backgroundColor: AppStyles.Black1C,
      ) ,
      
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
              "Welcome to Your App Name, where convenience meets automotive care! We specialize in providing a seamless car service appointment experience, designed to make your life easier.",
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
              "At Your App Name, our mission is to revolutionize the way you take care of your vehicle. We understand that scheduling car services can be time-consuming and frustrating. That's why we've developed a user-friendly platform that allows you to book appointments with ease, anytime, anywhere.",
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
            SizedBox(height: 10),
            Text(
              "Add Mode Feature: Our unique 'Add Mode' feature lets you customize your service appointment according to your specific needs. Whether it's a regular maintenance check or a major repair, we've got you covered.",
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
              "Behind Your App Name is a dedicated team of automotive enthusiasts who are passionate about delivering top-notch service. Here's a glimpse of our talented team:",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 10),
            Text(
              "1. John Smith (Founder & CEO): With over a decade of experience in the automotive industry, John leads our team with vision and expertise.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "2. Emily Johnson (Head of Operations): Emily ensures that every aspect of our app runs smoothly, from booking appointments to customer support.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "3. Michael Davis (Lead Developer): Michael is the genius behind the seamless functionality of our app, constantly innovating to enhance user experience.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "4. Sarah Brown (Marketing Manager): Sarah spreads the word about Your App Name, making sure car owners everywhere know about our convenient services.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            Text(
              "5. David Wilson (Customer Relations Specialist): David is here to assist you every step of the way, ensuring your experience with Your App Name is nothing short of exceptional.",
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
              "Ready to experience hassle-free car service appointments? Download Your App Name today and join thousands of satisfied customers who trust us with their automotive needs.",
              style: TextStyle(fontSize: 16, color: AppStyles.Black1C),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Contact Us:",
                  style: TextStyle(
                      color:
                      AppStyles.Black1C,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),
            // SizedBox(height: 10),
            Row(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("SMS:"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Positioned(

                      child: IconButton(
                        icon: Icon(
                          Icons.sms,
                          color: AppStyles.Black1C,
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
                  ],
                )
              ],

            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("E-mail:"),
                Positioned(
                  child: IconButton(
                    icon:  Icon(
                      Icons.email,
                      color: AppStyles.Black1C,
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
            SizedBox(height: 10),
          ],
        ),
      ),

      backgroundColor: AppStyles.GrayC,

      //bottomNavigationBar
      /*
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Container(
          height: 125,
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Contact Us:",
                    style: TextStyle(
                        color:
                        AppStyles.Black1C,
                        fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SMS:"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Positioned(

                        child: IconButton(
                          icon: Icon(
                            Icons.sms,
                            color: AppStyles.Black1C,
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
                    ],
                  )
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("E-mail:"),
                  Positioned(
                    child: IconButton(
                      icon:  Icon(
                        Icons.email,
                        color: AppStyles.Black1C,
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
              )
            ],
          )

        ),
      ),
      */
    );
  }
}
