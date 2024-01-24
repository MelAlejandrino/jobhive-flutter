import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobhive/repository/post_repository.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;
import 'package:provider/provider.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAbout extends StatefulWidget {
  const ProfileAbout({Key? key}) : super(key: key);

  @override
  _ProfileAboutState createState() => _ProfileAboutState();
}

class _ProfileAboutState extends State<ProfileAbout> {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      String userId = authProvider.user!.uid;

      return Scaffold(
        appBar: AppBar(
          title: Text('About Me'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: usersCollection.doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.hasData) {
                Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;


                String fullName =
                    authProvider.user!.firstName + " " + authProvider.user!.lastName;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      _buildAboutItem(
                        icon: Icons.person,
                        title: 'Fullname',
                        content: userData['firstName'] +" "+ userData['lastName'] ?? '',
                      ),
                      _buildAboutItem(
                        icon: Icons.person,
                        title: 'Username',
                        content: userData['username'] ?? '',
                      ),
                      _buildAboutItem(
                        icon: Icons.email,
                        title: 'Email',
                        content: userData['email'] ?? '',
                      ),
                      _buildAboutItem(
                        icon: Icons.location_on,
                        title: 'Location',
                        content: userData['location'] ?? '',
                      ),
                      // Add more items as needed based on your user data
                    ],
                  ),
                );
              }
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      );
    }

    // Handle the case when the user is null
    return Scaffold(
      body: Center(
        child: Text('User not found'),
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(content),
            ],
          ),
        ],
      ),
    );
  }
}
