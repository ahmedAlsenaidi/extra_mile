// import '../Screens/LogIn.dart';
// import 'package:flutter/material.dart';
//
// import '../ReusableCode/AppStyles.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   State<Signup> createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<Signup> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, //.fromRGBO(29, 39, 49, 1),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.width * 1.2,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Color.fromRGBO(8, 60, 93, 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Padding(padding: EdgeInsets.all(12.0)),
//                 Text("Sign up", style: AppStyles.headlineStyle1),
//                 const SizedBox(height: 6),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //User name
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: 'Enter your Username',
//                             hintStyle: TextStyle(color: Colors.white),
//                           ),
//                           style: AppStyles.headlineStyle2,
//                           validator: (String? value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                         const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
//                         //e-mail
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: 'Enter your e-mail',
//                             hintStyle: TextStyle(color: Colors.white),
//                           ),
//                           style: AppStyles.headlineStyle2,
//                           validator: (String? value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                         //password
//                         const Padding(padding: const EdgeInsets.symmetric(vertical: 16.0)),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: 'Enter your Password',
//                             hintStyle: TextStyle(color: Colors.white),
//                           ),
//                           style: AppStyles.headlineStyle2,
//                           validator: (String? value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                         const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
//                         //submit
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('Sign up', style: AppStyles.headlineStyle3),
//                         ),
//                         const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const Login()),
//                             );
//                           },
//                           child: Text(
//                             "already have an account? Log in",
//                             style: AppStyles.headlineStyle2,
//                           ),
//                         ),
//                         const Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:extra_mile/Data/DatabaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:extra_mile/Screens/Login.dart';

import '../ReusableCode/AppStyles.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If sign-up is successful, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      // Handle sign-up errors here
      print('Error during sign-up: $e');
      // You can show an error message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(8, 60, 93, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(12.0)),
                Text("Sign up", style: AppStyles.headlineStyle1),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Username',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: AppStyles.headlineStyle2,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your e-mail',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: AppStyles.headlineStyle2,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: AppStyles.headlineStyle2,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                        ElevatedButton(
                          onPressed: signUp,
                          child: Text('Sign up', style: AppStyles.headlineStyle3),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          },
                          child: Text(
                            "already have an account? Log in",
                            style: AppStyles.headlineStyle2,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
