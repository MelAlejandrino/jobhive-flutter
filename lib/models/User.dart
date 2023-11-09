import 'dart:typed_data';

class User {
  final String id;
  final String email;
  final String firstName;
  final String imageLink;
  final String lastName;
  final String password;
  final DateTime timestamp;
  final String uid;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.imageLink,
    required this.lastName,
    required this.password,
    required this.timestamp,
    required this.uid,
    required this.username,
  });
}
