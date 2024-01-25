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

  Stream<QuerySnapshot> getPosts() {
     final postStream = FirebaseFirestore.instance
      .collection('posts')
      .where('privacy_status', isEqualTo: 'Public')
      .snapshots();
    return postStream;
  }

  Stream<QuerySnapshot> getSearchPost(List<String> searchTextList) {
     final postStream = FirebaseFirestore.instance
      .collection('posts')
      .where('caption', whereIn: searchTextList)
      .snapshots();
    return postStream;
  }
    Stream<QuerySnapshot> getFeed(String authId) {
     final postStream = FirebaseFirestore.instance
      .collection('posts')
      .where('privacy_status', isEqualTo: 'Public')
      .where('user_uid', isEqualTo: authId)
      .snapshots();
    return postStream;
  }
}
