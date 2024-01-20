import 'package:flutter/material.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2.0,
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 23.0),
              child: Container(
                width: 135, // Adjust the width as needed
                child: Image.asset('assets/jobhive.png'), // Asset path
              ),
            ),
            const SizedBox(width: 16), // Adjust spacing
            Padding(
              padding: const EdgeInsets.only(top: 23.0),
              child: Container(
                height: 33,
                width: 140, // Adjust the width as needed
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
                    const SizedBox(width: 2), // Adjust spacing
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Center(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Search for jobs',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2), // Adjust spacing
            Padding(
              padding: const EdgeInsets.only(top: 14.0), // Adjust top padding
              child: Container(
                width: 50, // Adjust the width as needed
                height: 33, // Match the height of the TextFormField
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
      ),
    );
  }
}
