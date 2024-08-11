// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FoodDetailsScreen extends StatelessWidget {
//   const FoodDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Center(
//           child: Text(
//             'Food Detail Screen',
//             style: TextStyle(fontSize: 22.sp, color: Colors.white),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(15.0), // Rounded corners
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 spreadRadius: 3,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // Shadow position
//               ),
//             ],
//           ),
//           height: 600,
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 width: 300,
//                 color: Colors.blue,
//                 child: Image.network(
//                   'https://example.com/image.jpg', // Replace with your image URL
//                   fit: BoxFit.cover, // Adjust the image fit as needed
//                 ),
//               ),
//               const SizedBox(
//                 height: 300,
//                 width: 300,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text('Food Name', style: TextStyle(fontSize: 18)),
//                     Text('Food Timing', style: TextStyle(fontSize: 18)),
//                     Text('Food Delivery', style: TextStyle(fontSize: 18)),
//                     Text('Location', style: TextStyle(fontSize: 18)),
//                     Text('Number of people', style: TextStyle(fontSize: 18)),
//                     Text('Phone Number', style: TextStyle(fontSize: 18)),
//                     Text('Price ', style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
