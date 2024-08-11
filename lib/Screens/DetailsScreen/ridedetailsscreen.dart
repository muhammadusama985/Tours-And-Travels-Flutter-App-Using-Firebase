import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDetailsScreen extends StatelessWidget {
  final DocumentSnapshot ride;

  const RideDetailsScreen({
    super.key,
    required this.ride,
  });

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
       backgroundColor: Colors.cyan.shade200,
      appBar: AppBar(
        title: Text(ride['carName']),
      ),
      body: Center(
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
                color: Colors.blue,
                child: Image.network(
                  ride['imageUrl'], // Use ride data to display image
                  fit: BoxFit.cover, // Adjust the image fit as needed
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailItem(
                        'Car Name', ride['carName'], Icons.directions_car),
                    _buildDetailItem('Car Number', ride['carNumber'],
                        Icons.confirmation_number),
                    _buildDetailItem(
                        'Drop Point', ride['dropPoint'], Icons.pin_drop),
                    _buildDetailItem(
                        'Pickup Point', ride['pickupPoint'], Icons.location_on),
                    _buildDetailItem(
                        'Price Rs', ride['price'], Icons.attach_money),
                    _buildDetailItem('Seats Available', ride['seatsAvailable'],
                        Icons.event_seat),
                    _buildDetailItem(
                        'Phone Number', ride['phoneNumber'], Icons.phone),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 150.w,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchPhone(ride[
                        'phoneNumber']); // Call method to launch phone call
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Round border
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String heading, String data, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: Colors.black,
          size: 20.sp,
        ),
        const SizedBox(width: 10),
        Text(
          heading,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
        SizedBox(width: 20.w),
        Text(
          data,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.teal,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
      ],
    );
  }
}
