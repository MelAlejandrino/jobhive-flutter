import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page-1/new-user-name.dart';
import 'package:myapp/utilityforsignup.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // signinAPz (1:2)
        padding: EdgeInsets.fromLTRB(23*fem, 87*fem, 24*fem, 98*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group741J8 (1:3)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 30*fem, 28*fem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // jobhive1187r (1:4)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 17*fem),
                    width: 137*fem,
                    height: 30*fem,
                    child: Image.asset(
                      'assets/page-1/images/jobhive-1-1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    // signupzQx (1:5)
                    'Sign up.',
                    style: SafeGoogleFont (
                      'Inter',
                      fontSize: 75*ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.2125*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // usernamefieldgoa (1:9)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // usernameoNQ (1:11)
                    margin: EdgeInsets.fromLTRB(7*fem, 0*fem, 0*fem, 5*fem),
                    child: Text(
                      'username',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125*ffem/fem,
                        color: Color(0xff787878),
                      ),
                    ),
                  ),
                  Container(
                    // rectangle14gSC (1:10)
                    width: double.infinity,
                    height: 48*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(11*fem),
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0x00d9d9d9),
                    ),
                    child: TextField(
                      decoration: InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // emailfieldAcG (1:6)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // email6F2 (1:8)
                    margin: EdgeInsets.fromLTRB(7*fem, 0*fem, 0*fem, 5*fem),
                    child: Text(
                      'email',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125*ffem/fem,
                        color: Color(0xff787878),
                      ),
                    ),
                  ),
                  Container(
                    // rectangle14cDN (1:7)
                    width: double.infinity,
                    height: 48*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(11*fem),
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0x00d9d9d9),
                    ),
                    child: TextField(
                      decoration: InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // passwordfieldvjr (1:13)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // passwordEkY (1:15)
                    margin: EdgeInsets.fromLTRB(7*fem, 0*fem, 0*fem, 4*fem),
                    child: Text(
                      'password',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125*ffem/fem,
                        color: Color(0xff787878),
                      ),
                    ),
                  ),
                  Container(
                    // rectangle15MKN (1:14)
                    width: double.infinity,
                    height: 48*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(11*fem),
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0x00d9d9d9),
                    ),
                    child: TextField(
                      decoration: InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // signupbuttonT7W (1:16)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 193*fem, 19*fem),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewUserName()),
                  );
                },
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 135*fem,
                  height: 47*fem,
                  decoration: BoxDecoration (
                    color: Color(0xff000000),
                    borderRadius: BorderRadius.circular(11*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Sign  up.',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.2125*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // alreadyhaveanaccountsigninRyS (1:12)
              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 0*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont (
                      'Inter',
                      fontSize: 13*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2125*ffem/fem,
                      color: Color(0xff787878),
                    ),
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                      ),
                      TextSpan(
                        text: 'Sign in!',
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 13*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125*ffem/fem,
                          decoration: TextDecoration.underline,
                          color: Color(0xff000000),
                          decorationColor: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}
