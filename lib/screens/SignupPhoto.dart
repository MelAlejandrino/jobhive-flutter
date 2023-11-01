import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utilityforsignup.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewUserPhoto extends StatefulWidget {
  @override
  _NewUserPhotoState createState() => _NewUserPhotoState();
}

class _NewUserPhotoState extends State<NewUserPhoto> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return new Scaffold(
      body: new Container(
        width: double.infinity,
        child: Container(
          // newuserphotottG (1:23)
          padding: EdgeInsets.fromLTRB(34 * fem, 106 * fem, 53 * fem, 85 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // addaprofilepictureCtx (1:25)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 65 * fem, 41 * fem),
                constraints: BoxConstraints(
                  maxWidth: 223 * fem,
                ),
                child: Text(
                  'Add a profile picture.',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 36 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                // autogroupfgp2Vt4 (D1QykCJ1CqJAwDF6YafGP2)
                margin: EdgeInsets.fromLTRB(55 * fem, 0 * fem, 36 * fem, 48 * fem),
                width: double.infinity,
                height: 170 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      // ellipse7Qk8 (1:24)
                      left: 17 * fem,
                      top: 17 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 164 * fem,
                          height: 155 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(82 * fem),
                              border: Border.all(color: Color(0xffffcd00)),
                              color: Color(0x00d9d9d9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // maleuserUjz (1:32)
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 200 * fem,
                          height: 200 * fem,
                          child: Image.asset(
                            'assets/page-1/images/male-user.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // addpicturebuttonP6G (1:26)
                margin: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 8 * fem),
                child: TextButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 268 * fem,
                    height: 45 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xff000000),
                      borderRadius: BorderRadius.circular(11 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Add Picture',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // skipbuttonCpQ (1:29)
                margin: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: TextButton(
                  onPressed: () {}, //navigator for the next page
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 268 * fem,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffffcd00)),
                      borderRadius: BorderRadius.circular(11 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Skip',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
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

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }
}
