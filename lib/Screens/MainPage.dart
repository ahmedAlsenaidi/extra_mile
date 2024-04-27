// import '../Screens/LogIn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'HomePage.dart';
//
// class MainPage extends StatelessWidget {
//   const MainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream:  FirebaseAuth.instance.authStateChanges(),
//         builder: (context,snapshot){
//           if (snapshot.hasData){
//
//             return HomePage(onUpdateBranch: (Branch, bool) {});
//
//           }else{
//             return const Login();
//           }
//
//         },
//       ),
//     );
//   }
// }
import '../Screens/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Check if the logged-in user's email is "ahmed@ahmed.com"
            User? user = snapshot.data;
            if (user!.email == user!.email) {
              return HomePage(onUpdateBranch: (Branch, bool) {});
            } else {
              // Redirect other users to login page
              return const Login();
            }
          } else {
            // No user logged in, show login page
            return const Login();
          }
        },
      ),
    );
  }
}
