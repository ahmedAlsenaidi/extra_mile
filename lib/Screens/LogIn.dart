import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ReusableCode/AppStyles.dart';
import '../main.dart';
import 'HomePage.dart';
import 'MainPage.dart';
import 'SignUp.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     // Navigate to the next screen upon successful login
  //   } catch (e) {
  //     // Handle authentication errors here
  //     print('Error signing in: $e');
  //     // Show a snack-bar or dialog to inform the user about the error
  //   }
  // }
  // Future<void> signIn(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     // Navigate to the next screen upon successful login
  //   } catch (e) {
  //     // Handle authentication errors here
  //     print('Error signing in: $e');
  //     // Show a snack-bar to inform the user about the error
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error signing in: $e'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }
  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to the home page upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainApp()), // Replace HomePage with your actual home page widget
      );
    } catch (e) {
      // Handle authentication errors here
      print('Error signing in: $e');
      // Show a snack-bar to inform the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Extra Mile",
                  style: AppStyles.Black1.copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle
                          .italic), // Change the fontSize to your desired value
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Container(
                  // color: Colors.purple,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppStyles.TealC),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(12.0)),
                      Text("Log in",
                          style: AppStyles.Black2.copyWith(
                              fontSize: 25, fontWeight: FontWeight.w900)),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.0),
                            ),
                            //email
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter your e-mail',
                                hintStyle: AppStyles.Gray.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyles.Black2C),
                                ),
                              ),
                              style: AppStyles.Gray.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              // Set textInputAction
                              cursorColor: AppStyles.Black2C,
                            ),
                            //password
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Enter your Password',
                                hintStyle: AppStyles.Gray.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppStyles.Black2C),
                                ),
                              ),
                              style: AppStyles.Gray.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                // You can add more specific validation rules here
                                return null;
                              },
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              // Set textInputAction
                              cursorColor: AppStyles.Black2C,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            //submit
                            ElevatedButton(
                              onPressed: () => signIn(context),
                              // Pass the context here
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppStyles.GrayC,
                              ),
                              child: Text(
                                'Log in',
                                style: AppStyles.Black1.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),

                            // ElevatedButton(
                            //     onPressed: signIn,
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: AppStyles.GrayC,
                            //       /*padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            //       textStyle: TextStyle(
                            //           fontSize: 30,
                            //           fontWeight: FontWeight.bold)*/
                            //     ),
                            //     child: Text('Log in',
                            //         style:
                            //         AppStyles.Black1.copyWith(fontSize: 15,fontWeight: FontWeight.w600))),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()),
                                );
                              },
                              child: Text("Don't have Account? Sign up",
                                  style: AppStyles.Black2.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.zero,child: Text("""
              
              Email: yarab@adminextramail.com
              Pass: yarabyarab
              
              Email: usama@adminextramail.com
              Pass: usamausama
              
              Email: mohammed@adminextramile.com
              Pass: mohammedmohammed
              
              Email: al-salt@adminextramail.com
              Pass: alsaltalsalt
              
              Email: ahmed@adminextramile.com
              Pass: ahmedahmed
              """),),

            ],
          ),
        ),
      ),
    );
  }
}
