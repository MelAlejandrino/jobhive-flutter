import 'package:flutter/material.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

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
	    appBar: custom_search.SearchBar() as PreferredSizeWidget?,
            body: ListView.builder(
              itemCount: noTificate.length,
              itemBuilder: (context, index) {
                final Notif Not = noTificate[index];
                
                return Container(
                    color: (index % 2 == 0) ? Colors.teal[20] : Colors.teal[50],
                    child: ListTile(
                      leading: SizedBox(
                        width: 64, height: 64, child: CircleAvatar(backgroundImage: NetworkImage(Not.pic))),
                    title: Text(
                      Not.text,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                      subtitle: Text(Not.time),
                      trailing: const Icon(Icons.more_vert),
                    ),
                );      
              },
            )
        )
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