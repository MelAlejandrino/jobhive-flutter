import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobhive/models/Post.dart';

class PostRepository {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(
      String userUid, String caption, String postUid, String user_name, String user_photo, String privacyStatus) {
    return posts.doc(postUid).set({
      'user_uid': userUid,
      'caption': caption,
      'uid': postUid,
      'timestamp': Timestamp.now(),
      'user_name': user_name,
      'user_photo': user_photo,
      'privacy_status': privacyStatus,
    });
  }

  Stream<QuerySnapshot> getPosts(String authId) {
     final postStream = FirebaseFirestore.instance
      .collection('posts')
      .where('user_uid', isNotEqualTo: authId)
      .where('privacy_status', isEqualTo: 'Public')
      .snapshots();
    return postStream;
  }
}
