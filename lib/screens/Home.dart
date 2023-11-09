import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobhive/repository/post_repository.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;
import 'package:provider/provider.dart';
import 'package:jobhive/provider/auth_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostRepository _postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      String username = authProvider.user!.username;
      print('Username: $username');
    }
    return MaterialApp(
      home: Scaffold(
          appBar: const custom_search.SearchBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: StreamBuilder<QuerySnapshot>(
            stream: _postRepository.getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    String userPhoto = data['user_photo'] ?? 'assets/jobhive.png';
                    String userName = data['user_name'];
                    String postCaption = data['caption'];

                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 64.0,
                                height: 64.0,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(userPhoto),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      16.0), // Add spacing between photo and name
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  8.0), // Add spacing between name and caption
                          Text(
                            postCaption,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                              height:
                                  8.0), // Add spacing between caption and time
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          )),
    ));
  }
}
