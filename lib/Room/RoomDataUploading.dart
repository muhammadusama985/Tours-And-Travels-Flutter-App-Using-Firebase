import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/NewAccountSelection/NewAccountSelection.dart';

class RoomUploadingData extends StatefulWidget {
  const RoomUploadingData({
    super.key,
  });

  @override
  _RoomUploadingDataState createState() => _RoomUploadingDataState();
}

class _RoomUploadingDataState extends State<RoomUploadingData> {
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController roomAddressController = TextEditingController();
  final TextEditingController roomSizeController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController numOfRoomsController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();
  final TextEditingController roomConditionController = TextEditingController();
  final TextEditingController roomPriceController = TextEditingController();
  final TextEditingController roomOwnerNumberController =
      TextEditingController();
  final _firstNameController = TextEditingController();

  bool _isUploading = false;
  File? _roomImage;
  File? _userImage;
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
        _roomImage = File(pickedFile.path);
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

    final roomName = roomNameController.text;
    final roomNumber = roomNumberController.text;
    final roomAddress = roomAddressController.text;
    final roomSize = roomSizeController.text;
    final seats = seatsController.text;
    final numOfRooms = numOfRoomsController.text;
    final checkIn = checkInController.text;
    final checkOut = checkOutController.text;
    final roomCondition = roomConditionController.text;
    final roomPrice = roomPriceController.text;
    final roomOwnerNumber = roomOwnerNumberController.text;
    final firstName = _firstNameController.text;

    final Timestamp timestamp = Timestamp.now();
    final Reference carStorageReference = FirebaseStorage.instance
        .ref()
        .child('room_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask carUploadTask = carStorageReference.putFile(_roomImage!);
    await carUploadTask.whenComplete(() => null);
    final String roomImageUrl = await carStorageReference.getDownloadURL();

    // Upload image to Firebase Storage for user
    final Reference userStorageReference = FirebaseStorage.instance
        .ref()
        .child('user_images/${timestamp.millisecondsSinceEpoch}');
    final UploadTask userUploadTask = userStorageReference.putFile(_userImage!);
    await userUploadTask.whenComplete(() => null);
    final String userImageUrl = await userStorageReference.getDownloadURL();

    // Upload data to Firestore
    await FirebaseFirestore.instance.collection('Room').add({
      'userId': userId, // Include user ID
      'roomName': roomName,
      'roomNumber': roomNumber,
      'roomAddress': roomAddress,
      'roomSize': roomSize,
      'seats': seats,
      'numOfRooms': numOfRooms,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'roomCondition': roomCondition,
      'roomPrice': roomPrice,
      'roomOwnerNumber': roomOwnerNumber,
      'roomImageUrl': roomImageUrl,
      'userImageUrl': userImageUrl,
      'firstName': firstName,
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
          'Room Data Uploading',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
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
                          backgroundImage: _roomImage != null
                              ? FileImage(_roomImage!)
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
                        labelText: 'First Name',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomNameController,
                        labelText: 'Room Name',
                        icon: Icons.room,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomNumberController,
                        labelText: 'Room Number',
                        icon: Icons.confirmation_number,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomAddressController,
                        labelText: 'Room Address',
                        icon: Icons.location_on,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomSizeController,
                        labelText: 'Room Size',
                        icon: Icons.aspect_ratio,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: seatsController,
                        labelText: 'No. of Seats',
                        icon: Icons.event_seat,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: numOfRoomsController,
                        labelText: 'No. of Rooms',
                        icon: Icons.hotel,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: checkInController,
                        labelText: 'Check-in Timings',
                        icon: Icons.access_time,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: checkOutController,
                        labelText: 'Check-out Timings',
                        icon: Icons.access_time,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomConditionController,
                        labelText: 'Room Condition',
                        icon: Icons.info,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomPriceController,
                        labelText: 'Room Price',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: roomOwnerNumberController,
                        labelText: 'Room Owner Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
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
