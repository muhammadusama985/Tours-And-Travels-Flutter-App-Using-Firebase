// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:solosavour/Screens/practice.dart';

// class FoodUploadingData extends StatefulWidget {
//   const FoodUploadingData({
//     super.key,
//   });

//   @override
//   _FoodUploadingDataState createState() => _FoodUploadingDataState();
// }

// class _FoodUploadingDataState extends State<FoodUploadingData> {
//   File? _foodImage;
//   File? _userImage;

//   final _foodNameController = TextEditingController();
//   final _noOfPeopleController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _foodTimingController = TextEditingController();
//   final _deliveryController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _firstNameController = TextEditingController();

//   bool _isUploading = false;

//   Future<void> _pickUserImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _userImage = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _foodImage = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _uploadData() async {
//     setState(() {
//       _isUploading = true;
//     });

//     final foodName = _foodNameController.text;
//     final noOfPeople = _noOfPeopleController.text;
//     final price = _priceController.text;
//     final location = _locationController.text;
//     final foodTiming = _foodTimingController.text;
//     final delivery = _deliveryController.text;
//     final phoneNumber = _phoneNumberController.text;
//     final firstName = _firstNameController.text;

//     final Timestamp timestamp = Timestamp.now();
//     final Reference carStorageReference = FirebaseStorage.instance
//         .ref()
//         .child('car_images/${timestamp.millisecondsSinceEpoch}');
//     final UploadTask carUploadTask = carStorageReference.putFile(_foodImage!);
//     await carUploadTask.whenComplete(() => null);
//     final String foodImageUrl = await carStorageReference.getDownloadURL();

//     // Upload image to Firebase Storage for user
//     final Reference userStorageReference = FirebaseStorage.instance
//         .ref()
//         .child('user_images/${timestamp.millisecondsSinceEpoch}');
//     final UploadTask userUploadTask = userStorageReference.putFile(_userImage!);
//     await userUploadTask.whenComplete(() => null);
//     final String userImageUrl = await userStorageReference.getDownloadURL();

//     // Upload data to Firestore
//     await FirebaseFirestore.instance.collection('FoodData').add({
//       'foodName': foodName,
//       'noOfPeople': noOfPeople,
//       'price': price,
//       'location': location,
//       'foodTiming': foodTiming,
//       'delivery': delivery,
//       'phoneNumber': phoneNumber,
//       'foodImageUrl': foodImageUrl,
//       'userImageUrl': userImageUrl,
//       'firstName': firstName,
//       'timestamp': timestamp.toDate(), // Add the image URL to Firestore
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
//         title: Text(
//           'Food Data Uploading',
//           style: TextStyle(
//             fontSize: 16.sp,
//             color: Colors.white,
//             fontFamily: 'Urbanist-VariableFont_wght.ttf',
//           ),
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.w),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         _pickImage(ImageSource.gallery); // For car image
//                       },
//                       child: CircleAvatar(
//                         radius: 45.h,
//                         backgroundColor: Colors.transparent,
//                         backgroundImage: _foodImage != null
//                             ? FileImage(_foodImage!)
//                             : const AssetImage('assets/images/Uploadimage.jpg')
//                                 as ImageProvider<Object>?,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _pickUserImage(ImageSource.gallery); // For user image
//                       },
//                       child: CircleAvatar(
//                         radius: 45.h,
//                         backgroundColor: Colors.transparent,
//                         backgroundImage: _userImage != null
//                             ? FileImage(_userImage!)
//                             : const AssetImage('assets/images/images.png')
//                                 as ImageProvider<Object>?,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         controller: _firstNameController,
//                         labelText: 'First Name',
//                         icon: Icons.person,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _foodNameController,
//                         labelText: 'Food Name',
//                         icon: Icons.restaurant,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _noOfPeopleController,
//                         labelText: 'Number of People',
//                         icon: Icons.people,
//                         keyboardType: TextInputType.number,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _priceController,
//                         labelText: 'Price',
//                         icon: Icons.money,
//                         keyboardType: TextInputType.number,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _locationController,
//                         labelText: 'Location',
//                         icon: Icons.location_on,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _foodTimingController,
//                         labelText: 'Food Timing',
//                         icon: Icons.timer,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomTextField(
//                         controller: _deliveryController,
//                         labelText: 'Delivery',
//                         icon: Icons.local_shipping,
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
