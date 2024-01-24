import 'package:flutter/material.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Notif> noTificate = [
    Notif(
      pic:
      'https://plus.unsplash.com/premium_photo-1664453547090-0e8a92a6ed4c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZmFjZXxlbnwwfHwwfHx8MA%3D%3D',
      text: 'Comm Pahnee has visited your profile',
      time: '2 hrs',
    ),
    Notif(
      pic:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJlfkibsBdp0UWhfZwaCIAS2hK6FQB3uXJqQ&usqp=CAU',
      text: 'Biz E. Ness has liked your profile',
      time: '6 hrs',
    ),
    Notif(
      pic:
      'https://static.independent.co.uk/2023/06/13/15/newFile-7.jpg',
      text: 'Jacob J. Ester has followed your Profile',
      time: '7 hrs',
    ),
    Notif(
      pic:
      'https://as2.ftcdn.net/v2/jpg/04/69/32/91/1000_F_469329169_9OXvEmLTJ0qqUfaaXwauQKLra9r5uD6E.jpg',
      text: 'New Job matches',
      time: '8 hrs',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: custom_search.SearchBar(onSearchTextChanged: (String ) {  },) as PreferredSizeWidget?,
        body: ListView.builder(
          itemCount: noTificate.length,
          itemBuilder: (context, index) {
            final Notif notif = noTificate[index];

            return Card(
              color: (index % 2 == 0) ? Colors.white : Colors.grey[300],
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(notif.pic),
                ),
                title: Text(
                  notif.text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notif.time),
                trailing: const Icon(Icons.more_vert),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Notif {
  final String pic;
  final String text;
  final String time;

  Notif({
    required this.pic,
    required this.text,
    required this.time,
  });
}
