import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobhive/screens/SignupUserName.dart';
import 'package:jobhive/screens/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhive/repository/user_repository.dart';
import 'package:jobhive/screens/auth_check_screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int regist = 0;
  String? error;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository firestoreUser = UserRepository();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        firestoreUser.addUser(
          userCredential.user!.uid,
          _usernameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewUserName()),
        );
      }
    } catch (e) {
      regist = 1;
      error = e.toString();
      print('Error during registration: ${e.toString()}');
    }
  }
  //Global key for Form
  final signup = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/jobhive.png',
              width: 137,
              height: 30,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'Sign up.',
              style: GoogleFonts.inter(
                fontSize: 70,
                fontWeight: FontWeight.w700,
                color: const Color(0xff000000),
              ),
            ),
            //form for signup
            Form(
              key: signup,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      controller: _usernameController,
                      //validator
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: _emailController,
                      //validator
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      //validator
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 20),
                ]
              )
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (signup.currentState!.validate()) {
                    _registerUser(context);
                    if (regist == 1) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Error"),
                          content: Text("An error has occurred during registration. $error"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("okay"),
                            ),
                          ],
                        ),
                      );
                      //sets value back to 0 for loop
                      regist = 0;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                         backgroundColor: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff787878),
                ),
                children: [
                  const TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Sign in!',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff000000),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthCheckScreen()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )));
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const TextFieldWidget({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff787878),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
