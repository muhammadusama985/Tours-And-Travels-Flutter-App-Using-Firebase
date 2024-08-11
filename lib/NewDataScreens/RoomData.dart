// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:solosavour/preview.dart';

// class RoomData extends StatelessWidget {
//   const RoomData({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Room Data List'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('Room').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No data available'));
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;
//               return RoomDataCard(data: data);
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class RoomDataCard extends StatelessWidget {
//   final Map<String, dynamic> data;

//   const RoomDataCard({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Preview(
//               imageUrl: data['imageUrl'],
//               roomName: data['roomName'],
//               roomAddress: data['roomAddress'],
//               roomPrice: int.parse(data['roomPrice'].toString()),
//               roomNumber: data['roomNumber'],
//               seats: data['seats'],
//               numOfRooms: data['numOfRooms'],
//               checkIn: data['checkIn'],
//               checkOut: data['checkOut'],
//               roomCondition: data['roomCondition'],
//               roomOwnerNumber: data['roomOwnerNumber'],
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Stack(
//           children: <Widget>[
//             Container(
//               width: 350,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10.0),
//                 border: Border.all(color: Colors.grey),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: Container(
//                   width: 320,
//                   height: 110,
//                   color: Colors.white,
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Container(
//                           width: 100,
//                           height: 90,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.blue,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               data[
//                                   'imageUrl'], // Use the image URL from Firestore
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         width: 190,
//                         height: 100,
//                         color: Colors.white,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               data['roomName'],
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Text(
//                               data['roomAddress'],
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             Text(
//                               'Room Price: Rs ${int.parse(data['roomPrice'].toString())}',
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'Check In: ${data['checkIn']}',
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 5),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'Check Out: ${data['checkOut']}',
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
