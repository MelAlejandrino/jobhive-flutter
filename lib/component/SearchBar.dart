import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Image.asset('assets/jobhive.png', width: 50.0),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Search for Jobs',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.email, color: Colors.black,),
        ),
      ],
    );
  }
}
