import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solosavour/NewAccountSelection/NewAccountSelection.dart';

class Gadgetsuploading extends StatefulWidget {
  const Gadgetsuploading({
    super.key,
  });

  @override
  _GadgetsuploadingState createState() => _GadgetsuploadingState();
}

class _GadgetsuploadingState extends State<Gadgetsuploading> {
  File? _stuffImage;
  File? _userImage;

  final _stuffNameController = TextEditingController();
  final _stuffPriceController = TextEditingController();
  final _bookingTimingController = TextEditingController();
  final _returningTimingController = TextEditingController();
  final _stuffQualityController = TextEditingController();
  final _stuffQuantitiesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _stuffLocationController =
      TextEditingController(); // New controller for stuff location

  bool _isUploading = false;

  Future<void> _pickUserImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _userImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _stuffImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadData() async {
    setState(() {
      _isUploading = true;
    });

    // Obtain current user ID
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    final stuffName = _stuffNameController.text;
    final stuffPrice = _stuffPriceController.text;
    final bookingTiming = _bookingTimingController.text;
    final returningTiming = _returningTimingController.text;
    final stuffQuality = _stuffQualityController.text;
    final stuffQuantities = _stuffQuantitiesController.text;
    final phoneNumber = _phoneNumberController.text;
    final firstName = _firstNameController.text;
    final stuffLocation = _stuffLocationController.text; // Get stuff location

    final Timestamp timestamp = Timestamp.now();
    final Reference carStorageReference = FirebaseStorage.instance
        .ref()
        .child('stuff_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask carUploadTask = carStorageReference.putFile(_stuffImage!);
    await carUploadTask.whenComplete(() => null);
    final String stuffImageUrl = await carStorageReference.getDownloadURL();

    // Upload image to Firebase Storage for user
    final Reference userStorageReference = FirebaseStorage.instance
        .ref()
        .child('user_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask userUploadTask = userStorageReference.putFile(_userImage!);
    await userUploadTask.whenComplete(() => null);
    final String userImageUrl = await userStorageReference.getDownloadURL();

    // Upload data to Firestore
    await FirebaseFirestore.instance.collection('Gadgets').add({
      'userId': userId, // Include user ID

      'stuffName': stuffName,
      'stuffPrice': stuffPrice,
      'bookingTiming': bookingTiming,
      'returningTiming': returningTiming,
      'stuffQuality': stuffQuality,
      'stuffQuantities': stuffQuantities,
      'stuffImageUrl': stuffImageUrl,
      'userImageUrl': userImageUrl,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'stuffLocation': stuffLocation,
      'timestamp': timestamp.toDate(),
    });

    setState(() {
      _isUploading = false;
    });

    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.fade, // Set the transition type to fade
        child: const NewAccountSelection(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Gadgets Uploading',
          style: TextStyle(
            fontSize: 19.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImage(ImageSource.gallery); // For car image
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black, // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _stuffImage != null
                              ? FileImage(_stuffImage!)
                              : const AssetImage('assets/images/product.png')
                                  as ImageProvider<Object>?,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickUserImage(ImageSource.gallery); // For user image
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black, // Choose your border color
                            width: 2.0, // Choose your border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 45.h,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _userImage != null
                              ? FileImage(_userImage!)
                              : const AssetImage('assets/images/user.png')
                                  as ImageProvider<Object>?,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _firstNameController,
                        labelText: 'User Name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _stuffNameController,
                        labelText: 'Stuff name',
                        icon: Icons.title,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _stuffPriceController,
                        labelText: 'Stuff price',
                        icon: Icons.money,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _bookingTimingController,
                        labelText: 'Booking timing',
                        icon: Icons.schedule,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _returningTimingController,
                        labelText: 'Returning timing',
                        icon: Icons.schedule,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _stuffQualityController,
                        labelText: 'Stuff quality',
                        icon: Icons.star,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _stuffQuantitiesController,
                        labelText: 'Stuff quantities',
                        icon: Icons.numbers,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _phoneNumberController,
                        labelText: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _stuffLocationController,
                        labelText: 'Stuff location',
                        icon: Icons.location_on,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                _buildUploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: 300.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: _isUploading ? null : _uploadData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Round button border
          ),
        ),
        child: _isUploading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'Upload Data',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontFamily: 'Urbanist-VariableFont_wght.ttf',
                ),
              ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
