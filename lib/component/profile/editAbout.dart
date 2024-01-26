import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileAbout extends StatefulWidget {
  final String userId;

  const EditProfileAbout({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfileAboutState createState() => _EditProfileAboutState();
}

class _EditProfileAboutState extends State<EditProfileAbout> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc(widget.userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;

              fullNameController.text =
                  userData['firstName'] + " " + userData['lastName'] ?? '';
              usernameController.text = userData['username'] ?? '';
              emailController.text = userData['email'] ?? '';
              locationController.text = userData['location'] ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildEditItem(
                          controller: fullNameController,
                          title: 'Fullname',
                          icon: Icons.verified_user_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fullname must not be empty';
                            }
                            return null;
                          },
                        ),
                        _buildEditItem(
                          controller: usernameController,
                          title: 'Username',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username must not be empty';
                            }
                            return null;
                          },
                        ),
                        _buildEditItem(
                          controller: emailController,
                          title: 'Email',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        _buildEditItem(
                          controller: locationController,
                          title: 'Location',
                          icon: Icons.location_on,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Location must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveEditedData();
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildEditItem({
    required TextEditingController controller,
    required IconData icon,
    required String title,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: validator,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveEditedData() {
    usersCollection.doc(widget.userId).update({
      'firstName': fullNameController.text.split(' ')[0],
      'lastName': fullNameController.text.split(' ')[1],
      'username': usernameController.text,
      'email': emailController.text,
      'location': locationController.text
    });
  }
}
