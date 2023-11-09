import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class StoreData {
  
final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  String imageUrl = '';

  Future<DocumentSnapshot> getLatestDocument() async {
    QuerySnapshot querySnapshot =
        await users.orderBy('timestamp', descending: true).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception('No documents found in the collection');
    }
  }

  Future<String> saveData({required String file}) async {
    DocumentSnapshot userSnapshot = await getLatestDocument();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    String uid = userData['uid'];
    String name = userData['username'];
    String resp = "Some error occured";
    print(imageUrl);

    if (uid != null) {
      try {
        String imageUrl = file;
        print(imageUrl);
        await users.doc(uid).update({
          'imageLink': imageUrl,
        });
        resp = 'success';
      } catch (err) {
        resp = err.toString();
      }
    }

    return resp;
  }
}
