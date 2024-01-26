import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:jobhive/provider/auth_provider.dart';

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

              // Initialize controller values with current user data
              fullNameController.text =
                  userData['firstName'] + " " + userData['lastName'] ?? '';
              usernameController.text = userData['username'] ?? '';
              emailController.text = userData['email'] ?? '';
              locationController.text = userData['location'] ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildEditItem(
                        controller: fullNameController,
                        title: 'Fullname',
                        icon: Icons.verified_user_rounded,
                      ),
                      _buildEditItem(
                        controller: usernameController,
                        title: 'Username',
                        icon: Icons.person,
                      ),
                      _buildEditItem(
                        controller: emailController,
                        title: 'Email',
                        icon: Icons.email,
                      ),
                      _buildEditItem(
                        controller: locationController,
                        title: 'Location',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Save edited data to Firestore or perform other actions
                          _saveEditedData();
                          Navigator.pop(
                              context); // Navigate back to the previous screen
                        },
                        child: Text('Save'),
                      ),
                    ],
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
                TextField(
                  controller: controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveEditedData() {
    // Implement logic to save edited data to Firestore or perform other actions
    usersCollection.doc(widget.userId).update({
      'firstName': fullNameController.text.split(' ')[0],
      'lastName': fullNameController.text.split(' ')[1],
      'username': usernameController.text,
      'email': emailController.text,
      'location': locationController.text
    });
  }
}
