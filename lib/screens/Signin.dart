import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:jobhive/screens/Signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //These two integers are for the error messages
  int user = 0;
  int pass = 0;
  Future<void> _loginUser(BuildContext context) async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('username', isEqualTo: _usernameController.text)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        String storedPassword = userData['password'];
        //set user to 2. Meaning found username and the code will move on
        user = 2;

        if (storedPassword == _passwordController.text) {
          authProvider.signIn(
            userId: userData['uid'],
            email: userData['email'],
            firstName: userData['firstName'],
            imageBytes: userData['imageLink'],
            lastName: userData['lastName'],
            password: storedPassword,
            timestamp: userData['timestamp'].toDate(),
            uid: userData['uid'],
            username: userData['username'],
          );
          //set pass to 2. Meaning correct password
          pass = 2;
        } else {
          //set pass to 1. Meaning mismatched password
          pass = 1;
          print('Incorrect password');
        }
      } else {
        //set user to 1. Meaning invalid credentials.
        user = 1;
        print('Username not found');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  //form key
  final login = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                'Sign in.',
                style: GoogleFonts.inter(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff000000),
                ),
              ),
              //form for validation on whether user inputs no items
              Form(
                key: login,
                child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    controller: _usernameController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (login.currentState!.validate()) {
                      _loginUser(context);
                      //checks if the Username is the cause of an error
                      if (user == 1) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Invalid Credentials"),
                            content: const Text("The inputted username is invalid."),
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
                        user = 0;
                      }
                      //this time, if Password is mismatched
                      else if (pass == 1) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Invalid Credentials"),
                            content: const Text("The password inputted does not match."),
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
                        //set pass to default value for the loop
                        pass = 0;
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
                      'Sign in',
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
                    const TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      text: 'Sign up!',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff000000),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
