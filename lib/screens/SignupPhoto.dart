import 'package:flutter/material.dart';
import 'package:jobhive/screens/auth_check_screen.dart';
import 'package:jobhive/screens/utilityforsignup.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'package:jobhive/resources/add_data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewUserPhoto extends StatefulWidget {
  const NewUserPhoto({super.key});

  @override
  _NewUserPhotoState createState() => _NewUserPhotoState();
}

class _NewUserPhotoState extends State<NewUserPhoto> {
  Uint8List? _selectedImage;
  String imageUrl = '';

  Future _pickImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? file = await await imagePicker.pickImage(source: ImageSource.gallery);
  print('${file?.path}');

  if (file != null) {
    final File imageFile = File(file.path);
    Uint8List bytes = await imageFile.readAsBytes();

    setState(() {
      _selectedImage = bytes;
    });
  }

  if (file == null) return;

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images');
  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  try {
    final metadata = {
      'contentType': 'image/png',
    };
    await referenceImageToUpload.putFile(File(file.path), SettableMetadata(contentType: 'image/png'));
    imageUrl = await referenceImageToUpload.getDownloadURL();
  } catch (error) {
    print('Error uploading image: $error');
  }
}


    void saveProfile() async {
    String resp = await StoreData().saveData(file: imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // newuserphotottG (1:23)
          padding: EdgeInsets.fromLTRB(34 * fem, 106 * fem, 53 * fem, 85 * fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // addaprofilepictureCtx (1:25)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 65 * fem, 41 * fem),
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
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(55 * fem, 0 * fem, 36 * fem, 48 * fem),
                width: double.infinity,
                height: 170 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      left: 17 * fem,
                      top: 17 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 164 * fem,
                          height: 164 *
                              fem, // Set the height and width to be equal for a perfect circle
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffffcd00)),
                                color: const Color(0x00d9d9d9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 200 * fem,
                          height: 200 * fem,
                          child: ClipOval(
                            child: _selectedImage != null
                                ? Image.memory(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/jobhive.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // addpicturebuttonP6G (1:26)
                margin:
                    EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 8 * fem),
                child: TextButton(
                  onPressed: () async {
                    _pickImageFromGallery();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 268 * fem,
                    height: 45 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xff000000),
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
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: TextButton(
                  onPressed: () {
                    saveProfile();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthCheckScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 268 * fem,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffffcd00)),
                      borderRadius: BorderRadius.circular(11 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: const Color(0xff000000),
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
    ));
  }
}
