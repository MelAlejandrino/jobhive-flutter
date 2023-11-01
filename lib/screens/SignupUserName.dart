import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page-1/new-user-photo.dart';
import 'package:myapp/utilityforsignup.dart';



class NewUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return new Scaffold(
        body: new SingleChildScrollView(
      child: Container(
        // newusernameBVJ (1:33)
        padding: EdgeInsets.fromLTRB(34*fem, 107*fem, 53*fem, 137*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // whatsyournamehTe (1:43)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 78*fem, 68*fem),
              constraints: BoxConstraints (
                maxWidth: 210*fem,
              ),
              child: Text(
                'What’s your name?',
                style: SafeGoogleFont (
                  'Inter',
                  fontSize: 36*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2125*ffem/fem,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              // firstnameA6L (1:34)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 31*fem, 4*fem),
              width: 257*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // firstname3R2 (1:36)
                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 0*fem, 5*fem),
                    child: Text(
                      'first name',
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
                    // rectangle14AkY (1:35)
                    width: double.infinity,
                    height: 42*fem,
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
              // lastnameVnp (1:37)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 31*fem, 78*fem),
              width: 257*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // lastnameEEc (1:39)
                    margin: EdgeInsets.fromLTRB(7*fem, 0*fem, 0*fem, 5*fem),
                    child: Text(
                      'last name',
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
                    // rectangle14Ma8 (1:38)
                    width: double.infinity,
                    height: 42*fem,
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
              // nextbuttonTNG (1:40)
              margin: EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 0*fem),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewUserPhoto()),
                  );
                },
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 268*fem,
                  height: 29*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0xffffcd00)),
                    borderRadius: BorderRadius.circular(11*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.2125*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
        ),
          );
  }
}
