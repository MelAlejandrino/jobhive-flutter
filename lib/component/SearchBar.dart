import 'package:flutter/material.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../screens/search_by_audio.dart';
import 'package:jobhive/screens/search_prompt.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _SearchBarState extends State<SearchBar> {
  bool isSearchBarTapped = false;

  @override
  void initState() {
    super.initState();
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
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchPrompt(audioSearch: '',)),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          enabled: false, // Keep the field disabled
                          decoration: const InputDecoration(
                            hintText: 'Search for something',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          ),
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
