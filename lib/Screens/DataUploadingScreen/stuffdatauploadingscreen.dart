// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:solosavour/Screens/practice.dart';

// class StuffUploadingData extends StatefulWidget {
//   const StuffUploadingData({
//     super.key,
//   });

//   @override
//   _StuffUploadingDataState createState() => _StuffUploadingDataState();
// }

// class _StuffUploadingDataState extends State<StuffUploadingData> {
//   File? _image;
//   final _stuffNameController = TextEditingController();
//   final _stuffPriceController = TextEditingController();
//   final _bookingTimingController = TextEditingController();
//   final _returningTimingController = TextEditingController();
//   final _stuffQualityController = TextEditingController();
//   final _stuffQuantitiesController = TextEditingController();
//   final _phoneNumberController = TextEditingController();

//   bool _isUploading = false;

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _uploadData() async {
//     setState(() {
//       _isUploading = true;
//     });

//     final stuffName = _stuffNameController.text;
//     final stuffPrice = _stuffPriceController.text;
//     final bookingTiming = _bookingTimingController.text;
//     final returningTiming = _returningTimingController.text;
//     final stuffQuality = _stuffQualityController.text;
//     final stuffQuantities = _stuffQuantitiesController.text;
//     final phoneNumber = _phoneNumberController.text;

//     // Upload image to Firebase Storage
//     final Reference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('images/${DateTime.now().millisecondsSinceEpoch}');
//     final UploadTask uploadTask = storageReference.putFile(_image!);
//     await uploadTask.whenComplete(() => null);
//     final String imageUrl = await storageReference.getDownloadURL();

//     // Upload data to Firestore
//     await FirebaseFirestore.instance.collection('StuffData').add({
//       'stuffName': stuffName,
//       'stuffPrice': stuffPrice,
//       'bookingTiming': bookingTiming,
//       'returningTiming': returningTiming,
//       'stuffQuality': stuffQuality,
//       'stuffQuantities': stuffQuantities,
//       'imageUrl': imageUrl,
//       'phoneNumber': phoneNumber, // Add the image URL to Firestore
//     });

//     setState(() {
//       _isUploading = false;
//     });

//     Navigator.of(context).pushReplacement(
//       PageTransition(
//         type: PageTransitionType.fade, // Set the transition type to fade
//         child: const MyScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Center(
//           child: Text(
//             'Stuff Data Uploading',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.white,
//               fontFamily: 'Urbanist-VariableFont_wght.ttf',
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.w),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     _pickImage(ImageSource.gallery);
//                   },
//                   child: Container(
//                     width: 300.w,
//                     height: 170.h,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.teal),
//                       borderRadius: BorderRadius.circular(10),
//                       image: _image != null
//                           ? DecorationImage(
//                               image: FileImage(_image!),
//                               fit: BoxFit.cover,
//                             )
//                           : const DecorationImage(
//                               image:
//                                   AssetImage('assets/images/Uploadimage.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _stuffNameController,
//                         labelText: 'Stuff name',
//                         icon: Icons.title,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _stuffPriceController,
//                         labelText: 'Stuff price',
//                         icon: Icons.money,
//                         keyboardType: TextInputType.number,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _bookingTimingController,
//                         labelText: 'Booking timing',
//                         icon: Icons.schedule,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _returningTimingController,
//                         labelText: 'Returning timing',
//                         icon: Icons.schedule,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _stuffQualityController,
//                         labelText: 'Stuff quality',
//                         icon: Icons.star,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _stuffQuantitiesController,
//                         labelText: 'Stuff quantities',
//                         icon: Icons.numbers,
//                         keyboardType: TextInputType.number,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _phoneNumberController,
//                         labelText: 'Phone Number',
//                         icon: Icons.phone,
//                         keyboardType: TextInputType.phone,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 _buildUploadButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadButton() {
//     return SizedBox(
//       width: 300.w,
//       height: 50.h,
//       child: ElevatedButton(
//         onPressed: _isUploading ? null : _uploadData,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.teal,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30), // Round button border
//           ),
//         ),
//         child: _isUploading
//             ? const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               )
//             : Text(
//                 'Upload Data',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.white,
//                   fontFamily: 'Urbanist-VariableFont_wght.ttf',
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final IconData icon;
//   final TextInputType? keyboardType;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.labelText,
//     required this.icon,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//     );
//   }
// }
