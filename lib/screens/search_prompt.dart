import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobhive/repository/post_repository.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;
import 'package:provider/provider.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobhive/screens/search_by_audio.dart';
import 'package:jobhive/screens/Home.dart';

class SearchPrompt extends StatefulWidget {
  final String audioSearch;
  const SearchPrompt({super.key, required this.audioSearch});

  @override
  State<SearchPrompt> createState() => _SearchPromptState();
}

class _SearchPromptState extends State<SearchPrompt> {
  final PostRepository _postRepository = PostRepository();
  late TextEditingController controller;
  late FocusNode _focusNode;
  Map<String, bool> isExpandedMap = {};

  String query = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    controller = TextEditingController(
        text: widget.audioSearch.isNotEmpty ? widget.audioSearch : '');
    if (widget.audioSearch.isNotEmpty) {
      submitSearch();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void submitSearch() {
    _focusNode.unfocus();
    onQueryChanged(controller.text);
  }

  String getTimeDifference(Timestamp timestamp) {
    DateTime postTime = timestamp.toDate();
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(postTime);

    if (difference.inDays >= 14) {
      int weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    } else {
      return '${difference.inDays}d';
    }
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 23.0),
                child: Container(
                  height: 33,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          onSubmitted: (query) {
                            _focusNode.unfocus();
                            onQueryChanged(query);
                          },
                          onEditingComplete: () {
                            if (widget.audioSearch.isNotEmpty) {
                              submitSearch();
                            }
                          },
                          textInputAction: TextInputAction.search,
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Search for something',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Container(
                width: 50,
                height: 33,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.mic, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchByAudio()),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    String userPhoto =
                        data['user_photo'] ?? 'assets/jobhive.png';

                    Widget avatarWidget;
                    if (userPhoto.isNotEmpty) {
                      avatarWidget = CircleAvatar(
                        backgroundImage: NetworkImage(userPhoto),
                      );
                    } else {
                      avatarWidget = CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          width: 64.0,
                          height: 64.0,
                          child: Image.asset(
                            'assets/jobhive.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }

                    String postId = data['uid'];
                    bool isExpanded = isExpandedMap[postId] ?? false;

                    String userName = data['user_name'];
                    String postCaption = data['caption'];

                    Widget captionWidget = isExpanded
                        ? Text(
                            postCaption,
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              color: const Color.fromARGB(255, 99, 99, 99),
                            ),
                          )
                        : Text(
                            postCaption.length > 200
                                ? postCaption.substring(0, 200) + "..."
                                : postCaption,
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              color: const Color.fromARGB(255, 99, 99, 99),
                            ),
                          );

                    Timestamp timestamp = data['timestamp'];
                    String privacy_status = data['privacy_status'];

                    Widget privacyIcon() {
                      IconData icon;
                      double iconSize = 18.0;

                      switch (privacy_status) {
                        case 'Public':
                          icon = Icons.public;
                          break;
                        case 'Friends':
                          icon = Icons.group;
                          break;
                        case 'Only Me':
                          icon = Icons.lock;
                          break;
                        default:
                          icon = Icons.info;
                          break;
                      }

                      return Icon(
                        icon,
                        color: Color.fromARGB(98, 0, 0, 0),
                        size: iconSize,
                      );
                    }

                    String timeDifference = getTimeDifference(timestamp);
                    if (query.isNotEmpty) {
                      print(query);
                      final lowerCaseQuery = query.trim().toLowerCase();
                      final lowerCaseCaption = data['caption'].toLowerCase();

                      if (lowerCaseCaption.contains(lowerCaseQuery)) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 114, 114, 114),
                              width: 1.0,
                            ),
                          ),
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
                                    child: avatarWidget,
                                  ),
                                  SizedBox(width: 16.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userName,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            timeDifference,
                                            style: GoogleFonts.inter(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          privacyIcon(),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              captionWidget,
                              postCaption.length > 200
                                  ? TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isExpandedMap[postId] = !isExpanded;
                                        });
                                      },
                                      child: Text(
                                        isExpanded ? 'See Less' : 'See More',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              const SizedBox(height: 8.0),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.thumb_up_alt),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.thumb_down_alt),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return SizedBox.shrink();
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Text("no data");
              }
            },
          ),
        ),
      ),
    );
  }
}
