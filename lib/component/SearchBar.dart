import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Image.asset('assets/jobhive.png', width: 50.0),
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding
        child: TextField(
          style: TextStyle(fontSize: 16.0), // Adjust font size
          decoration: InputDecoration(
            hintText: 'Search for Jobs',
            contentPadding: EdgeInsets.symmetric(vertical: 12.0), // Adjust vertical padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.email, color: Colors.black,),
        ),
      ],
    );
  }
}
