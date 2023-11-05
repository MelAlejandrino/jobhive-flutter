import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobhive/models/Post.dart';

class PostRepository {
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Stream<QuerySnapshot>getPosts(){
    final postStream = posts.snapshots();

    return postStream;
  }
}
