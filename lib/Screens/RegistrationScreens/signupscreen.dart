import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solosavour/Screens/RegistrationScreens/loginscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  File? _image;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadUserData(User user, String imageUrl) async {
    await FirebaseFirestore.instance
        .collection('SolortripUserData')
        .doc(user.uid)
        .set({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'address': _addressController.text,
      'email': _emailController.text,
      'imageUrl': imageUrl, // Add the image URL field
      // Add more fields as needed
    });
  }

  Future<String> _uploadUserImage(User user) async {
    print('<<<<<<<<<<<<<<<<<<<Uploading user image...');
    if (_image != null) {
      Reference ref =
          FirebaseStorage.instance.ref('user_images').child('${user.uid}.jpg');
      try {
        await ref.putFile(_image!);
        String imageUrl = await ref.getDownloadURL();
        print(
            '<<<<<<<<<<<<<<<<<<<<<<<<<Image uploaded successfully: $imageUrl');
        return imageUrl; // Return the image URL
      } catch (e) {
        print('Error uploading image: $e');
        rethrow; // Re-throw the error
      }
    } else {
      print('No image selected for upload.');
      return ''; // Return empty string if no image is selected
    }
  }

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Upload the image and get its URL
        String imageUrl = await _uploadUserImage(user);

        // Upload user data along with the image URL
        await _uploadUserData(user, imageUrl);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      print("Error registering user: $e");
      // Handle registration errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0, // Remove elevation
        backgroundColor: Colors.cyan.shade200,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/bck.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), // Adjust opacity as needed
                    BlendMode.darken, // Choose the blend mode as needed
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                width: 400.w,
                height: 550.h,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/applogo.png',
                            width: 50.w,
                            height: 50.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'SoloSavour',
                            style: TextStyle(
                              color: Colors.cyan.shade400,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Urbanist-VariableFont_wght.ttf',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: SizedBox(
                        width: 250.0,
                        child: Text(
                          'Join the community!! Sign up',
                          style: TextStyle(
                            color: Colors.cyan.shade400,
                            fontSize: 14.sp,
                            fontFamily: 'Urbanist-VariableFont_wght.ttf',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _pickImage(ImageSource.gallery);
                            },
                            child: SizedBox(
                              width: 120.w,
                              height: 100.h,
                              child: ClipOval(
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/images.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextFieldContainer(
                                  child: TextField(
                                    controller: _firstNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                  hintTextStyle: 'Your custom hint style here',
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _buildTextFieldContainer(
                                  child: TextField(
                                    controller: _lastNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                  hintTextStyle: 'Your custom hint style here',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          _buildTextFieldContainer(
                            child: TextField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.phone),
                                hintText: 'Enter phone number',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            hintTextStyle: 'Your custom hint style here',
                          ),
                          SizedBox(height: 5.h),
                          _buildTextFieldContainer(
                            child: TextField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.location_on),
                                hintText: 'Enter your address',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            hintTextStyle: 'Your custom hint style here',
                          ),
                          SizedBox(height: 5.h),
                          _buildTextFieldContainer(
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.email),
                                hintText: 'Enter your email',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            hintTextStyle: 'Your custom hint style here',
                          ),
                          SizedBox(height: 5.h),
                          _buildTextFieldContainer(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            hintTextStyle: 'Your custom hint style here',
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                text: 'Register',
                                onPressed: () async {
                                  try {
                                    // Register the user
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    User? user = userCredential.user;

                                    if (user != null) {
                                      // Upload the image and get its URL
                                      String imageUrl =
                                          await _uploadUserImage(user);

                                      // Upload user data along with the image URL
                                      await _uploadUserData(user, imageUrl);

                                      // Navigate to the login screen
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    }
                                  } catch (e) {
                                    print("Error registering user: $e");
                                    // Handle registration errors
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              const Text("Registration Error"),
                                          content: const Text(
                                              "An error occurred during registration. Please try again."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                color: Colors.cyan.shade400,
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
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 200.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5, // Add elevation for box shadow
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
      ),
    );
  }
}

Widget _buildTextFieldContainer(
    {required Widget child, required String hintTextStyle}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(15),
    ),
    child: child,
  );
}
