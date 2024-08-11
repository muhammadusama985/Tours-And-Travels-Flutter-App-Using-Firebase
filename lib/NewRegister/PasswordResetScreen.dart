import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solosavour/animation/animation.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({
    super.key,
  });

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 800),
                  child: RichText(
                    text: TextSpan(
                      text: 'Welcome To\n',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Urbanist-VariableFont_wght.ttf",
                        letterSpacing: 1,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Solo',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            letterSpacing: 1,
                            color: Colors.black, // Set the color to blue
                          ),
                        ),
                        TextSpan(
                          text: 'Savour',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            letterSpacing: 1,
                            color: Colors.blue, // Set the color to blue
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 1600),
                  child: Text(
                    "Reset Your Password",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 1800),
                child: Text(
                  "Forgot Your Password?",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2000),
                child: Text(
                  "No worries! Enter your email address ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2300),
                child: Text(
                  "to reset your password and regain access to ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2300),
                child: Text(
                  "your account.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2600),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2800),
                child: Text(
                  "Check your email we have sent a password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2800),
                child: Text(
                  "reset link",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2800),
                child: ElevatedButton(
                  onPressed: _loading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.green)
                        : const Text(
                            'Send Reset Link',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPassword() async {
    setState(() {
      _loading = true;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Fluttertoast.showToast(
        msg: 'Password reset email sent.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      ).then((value) => Navigator.pop(context));
    } catch (error) {
      print('Error sending password reset email: $error');
      Fluttertoast.showToast(
        msg: 'Failed to send password reset email.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3, // Set the duration of the toast message
      ).then((value) =>
          Navigator.pop(context)); // Navigate back after toast message ends
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
