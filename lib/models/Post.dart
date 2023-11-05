import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String userPhoto;
  final String caption;
  final int likes;

  Post(this.id, this.userId, this.userPhoto, this.caption, this.likes);

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Post(
      snapshot.id,
      snapshot.data()!['user_id'],
      snapshot.data()!['user_photo'],
      snapshot.data()!['caption'],
      snapshot.data()!['likes'],
    );
  }
}