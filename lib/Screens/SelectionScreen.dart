// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:solosavour/Screens/DataUploadingScreen/cardatauploadingscreen.dart';
// import 'package:solosavour/Screens/DataUploadingScreen/fooddatauploadingscreen.dart';
// import 'package:solosavour/Screens/DataUploadingScreen/roomdatauploadingscreen.dart';
// import 'package:solosavour/Screens/DataUploadingScreen/stuffdatauploadingscreen.dart';

// List<Widget> screens = [
//   const CarUploadingData(),
//   const FoodUploadingData(),
//   const StuffUploadingData(),
//   const RoomUploadingData(),
// ];

// class OptionScreen extends StatefulWidget {
//   const OptionScreen({super.key});

//   @override
//   _OptionScreenState createState() => _OptionScreenState();
// }

// class _OptionScreenState extends State<OptionScreen> {
//   int? selectedIndex;

//   final List<String> imagePaths = [
//     'assets/images/ride.jpeg',
//     'assets/images/fastfood.jpeg',
//     'assets/images/gadets.jpg',
//     'assets/images/Islamabad_Marriott.jpg',
//   ];

//   final List<String> texts = [
//     'Ride',
//     'Food',
//     'Stuff',
//     'Room',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         elevation: 0,
//         backgroundColor: Colors.teal,
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background Image
//           Image.asset(
//             'assets/images/bck.jpg',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: 4,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = index;
//                           });
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(
//                               color: selectedIndex == index
//                                   ? Colors.red
//                                   : Colors.white,
//                               width: selectedIndex == index ? 4 : 2,
//                             ),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 Image.asset(
//                                   imagePaths[index],
//                                   fit: BoxFit.cover,
//                                   color: Colors.black
//                                       .withOpacity(0.5), // Apply filter
//                                   colorBlendMode: BlendMode.darken,
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     texts[index],
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily:
//                                           'Urbanist-VariableFont_wght.ttf',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 250),
//                   child: SizedBox(
//                     height: 40.h,
//                     width: 200.w,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (selectedIndex != null) {
//                           Navigator.push(
//                             context,
//                             PageTransition(
//                               type: PageTransitionType
//                                   .fade, // Set the transition type to fade
//                               child: screens[selectedIndex!],
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.teal, // Text color
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(20.0), // Round border
//                         ),
//                         elevation: 5, // Box shadow
//                       ),
//                       child: Text(
//                         'Select',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Urbanist-VariableFont_wght.ttf',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
