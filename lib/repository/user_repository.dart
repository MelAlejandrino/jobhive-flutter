import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      String uid, String username, String email, String password) {
    return users.doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'timestamp': Timestamp.now(),
    });
  }

  Future<DocumentSnapshot> getLatestDocument() async {
  QuerySnapshot querySnapshot =
      await users.orderBy('timestamp', descending: true).limit(1).get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  } else {
    throw Exception('No documents found in the collection');
  }
}


  Future<void> addUserNames(String firstName, String lastName) async {
    DocumentSnapshot userSnapshot = await getLatestDocument();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    String uid = userData['uid'];
    print(uid);
    if (uid != null) {
      await users.doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
      });
    }
  }

  Future<DocumentSnapshot> getUser(String username) async {
    DocumentReference userRef = users.doc(username);
    DocumentSnapshot userSnapshot = await userRef.get();
    return userSnapshot;
  }
}
