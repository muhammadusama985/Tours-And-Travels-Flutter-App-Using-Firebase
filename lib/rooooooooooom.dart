import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomDataView extends StatelessWidget {
  const RoomDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Data View'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Room').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return buildRoomCard(data);
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buildRoomCard(Map<String, dynamic> data) {
    final roomName = data['roomName'] ?? '';
    final roomAddress = data['roomAddress'] ?? '';
    final roomPrice = data['roomPrice'] ?? '';
    final checkIn = data['checkIn'] ?? '';
    final checkOut = data['checkOut'] ?? '';
    final roomImageUrl = data['roomImageUrl'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: roomImageUrl.isNotEmpty
                    ? Image.network(
                        roomImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                        child: const Icon(Icons.image),
                      ),
                title: Text(
                  roomName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address: $roomAddress',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Price: $roomPrice',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'Check In: $checkIn',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Check Out: $checkOut',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
