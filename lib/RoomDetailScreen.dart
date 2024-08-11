import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room['roomName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display room image
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  room['imageUrl'],
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Display other room data
            ListTile(
              leading: const Icon(Icons.room),
              title: Text('Room Name: ${room['roomName']}'),
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_number),
              title: Text('Room Number: ${room['roomNumber']}'),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Room Address: ${room['roomAddress']}'),
            ),
            // Add more ListTile widgets to display other room data
          ],
        ),
      ),
    );
  }
}
