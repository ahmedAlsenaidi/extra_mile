import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ReusableCode/AppStyles.dart';
import 'SignUp.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the next screen upon successful login
    } catch (e) {
      // Handle authentication errors here
      print('Error signing in: $e');
      // Show a snack-bar or dialog to inform the user about the error
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
          child: Container(
            // color: Colors.purple,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(8, 60, 93, 1)
            ),
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.all(12.0)),
                  Text("Log in", style: AppStyles.headlineStyle1),
              
                  const SizedBox(height:6,),
              
                  Padding(padding: const EdgeInsets.all(16.0),
              
                    child: Form(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: EdgeInsets.symmetric(vertical: 40.0),),
                        //email
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
                          textInputAction: TextInputAction.next, // Set textInputAction
                        ),
                        //password
                        const Padding(padding:  EdgeInsets.symmetric(vertical: 16.0),),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(color: Colors.white)
                          ),
                          style: AppStyles.headlineStyle2 ,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            // You can add more specific validation rules here
                            return null;
                          },
                          obscureText: true,
                          textInputAction: TextInputAction.done, // Set textInputAction
                        ),
                        const Padding(padding:  EdgeInsets.symmetric(vertical: 16.0),),
                        //submit
                        ElevatedButton(
                            onPressed: signIn,
                            child:  Text('Log in', style: AppStyles.headlineStyle3)
                        ),
                        const Padding(padding:  EdgeInsets.symmetric(vertical: 16.0),),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Signup()),
                            );
                          },
              
                          child: Text("Don't have Account? Sign up", style: AppStyles.headlineStyle2),
              
                        ),
                        const Padding(padding:  EdgeInsets.symmetric(vertical: 12.0),),
              
                      ],
                    )
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