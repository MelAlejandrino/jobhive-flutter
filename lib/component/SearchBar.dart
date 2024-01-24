import 'package:flutter/material.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'search_by_audio.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({Key? key, required Null Function(dynamic text) onSearchTextChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _SearchBarState extends State<SearchBar> {
  bool isSearchBarTapped = false;
  late stt.SpeechToText _speech;
  String _currentSpeech = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (await _speech.initialize()) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _currentSpeech = result.recognizedWords;
          });
        },
      );
    }
  }

  void _navigateToSecondScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchByAudio()),
    );

    if (result != null) {
      setState(() {
        _currentSpeech = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 23.0),
            child: Container(
              width: 135,
              child: Image.asset('assets/jobhive.png'),
            ),
          ),
          const SizedBox(width: 16),
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
                      child: TextFormField(
                        onTap: () {
                          setState(() {
                            isSearchBarTapped = true;
                          });
                        },
                        controller: TextEditingController(text: _currentSpeech),
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
                    _startListening();
                    _navigateToSecondScreen(); // Navigate to the second screen
                  },
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
                  icon: const Icon(Icons.logout, color: Colors.grey),
                  onPressed: () {
                    authProvider.signOut();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
