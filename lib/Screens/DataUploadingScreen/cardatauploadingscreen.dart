import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/NewAccountSelection/NewAccountSelection.dart';

class CarUploadingData extends StatefulWidget {
  const CarUploadingData({
    super.key,
  });

  @override
  _CarUploadingDataState createState() => _CarUploadingDataState();
}

class _CarUploadingDataState extends State<CarUploadingData> {
  File? _carImage;
  File? _userImage;

  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();
  final TextEditingController pickupPointController = TextEditingController();
  final TextEditingController dropPointController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

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
        _carImage = File(pickedFile.path);
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

    final carName = carNameController.text;
    final carNumber = carNumberController.text;
    final pickupPoint = pickupPointController.text;
    final dropPoint = dropPointController.text;
    final phoneNumber = phoneNumberController.text;
    final seatsAvailable = seatsController.text;
    final price = priceController.text;
    final firstName = firstNameController.text;

    // Get current timestamp
    final Timestamp timestamp = Timestamp.now();

    // Upload image to Firebase Storage for car
    final Reference carStorageReference = FirebaseStorage.instance
        .ref()
        .child('car_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask carUploadTask = carStorageReference.putFile(_carImage!);
    await carUploadTask.whenComplete(() => null);
    final String carImageUrl = await carStorageReference.getDownloadURL();

    // Upload image to Firebase Storage for user
    final Reference userStorageReference = FirebaseStorage.instance
        .ref()
        .child('user_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask userUploadTask = userStorageReference.putFile(_userImage!);
    await userUploadTask.whenComplete(() => null);
    final String userImageUrl = await userStorageReference.getDownloadURL();

    // Upload data to Firestore
    await FirebaseFirestore.instance.collection('RidesData').add({
      'userId': userId, // Include user ID
      'carName': carName,
      'carNumber': carNumber,
      'pickupPoint': pickupPoint,
      'dropPoint': dropPoint,
      'phoneNumber': phoneNumber,
      'seatsAvailable': seatsAvailable,
      'price': price,
      'carImageUrl': carImageUrl,
      'userImageUrl': userImageUrl,
      'firstName': firstName,
      'timestamp': timestamp.toDate(), // Convert Timestamp to DateTime
    });

    setState(() {
      _isUploading = false;
    });

    // Navigate to home screen after upload
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.fade,
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
          'Ride Data Uploading',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
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
                      child: CircleAvatar(
                        radius: 45.h,
                        backgroundColor: Colors.transparent,
                        backgroundImage: _carImage != null
                            ? FileImage(_carImage!)
                            : const AssetImage('assets/images/product.png')
                                as ImageProvider<Object>?,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickUserImage(ImageSource.gallery); // For user image
                      },
                      child: CircleAvatar(
                        radius: 45.h,
                        backgroundColor: Colors.transparent,
                        backgroundImage: _userImage != null
                            ? FileImage(_userImage!)
                            : const AssetImage('assets/images/user.png')
                                as ImageProvider<Object>?,
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
                        controller: firstNameController,
                        labelText: 'First Name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: carNameController,
                        labelText: 'Car Name',
                        icon: Icons.directions_car,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: carNumberController,
                        labelText: 'Car Number',
                        icon: Icons.confirmation_number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: pickupPointController,
                        labelText: 'Pickup Point',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: dropPointController,
                        labelText: 'Drop Point',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: phoneNumberController,
                        labelText: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: seatsController,
                        labelText: 'Seats Available',
                        icon: Icons.event_seat,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: priceController,
                        labelText: 'Price',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
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
