import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class StuffDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? stuffData;

  const StuffDetailsScreen({super.key, required this.stuffData});

  @override
  State<StuffDetailsScreen> createState() => _StuffDetailsScreenState();
}

class _StuffDetailsScreenState extends State<StuffDetailsScreen> {
  void launchPhone(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.stuffData?['stuffName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                height: 600,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.teal,
                      child: Image.network(
                        widget.stuffData?[
                            'imageUrl'], // Use stuffData to get image URL
                        fit: BoxFit.contain, // Adjust the image fit as needed
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        _buildDetailRow(
                            'Stuff Name', widget.stuffData?['stuffName']),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow(
                            'Price', 'Rs ${widget.stuffData?['stuffPrice']}'),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow('Booking Timing',
                            widget.stuffData?['bookingTiming']),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow('Returning Timing',
                            widget.stuffData?['returningTiming']),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow(
                            'Stuff Quality', widget.stuffData?['stuffQuality']),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow('Stuff Quantities',
                            widget.stuffData?['stuffQuantities']),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildDetailRow(
                            'Phone Number', widget.stuffData?['phoneNumber']),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 40.h,
                        width: 150.w,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            launchPhone(widget.stuffData?['phoneNumber']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20.0), // Round border
                            ),
                            elevation: 5, // Box shadow
                          ),
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Call', // Button label
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                               fontFamily: 'Urbanist-VariableFont_wght.ttf',
                            ),
                          ),
                        ),
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

  Widget _buildDetailRow(String heading, String? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.info,
              color: Colors.black,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              heading,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                  fontFamily: 'Urbanist-VariableFont_wght.ttf',
              ),
            ),
          ],
        ),
        Text(
          data ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.teal,
              fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
      ],
    );
  }
}
