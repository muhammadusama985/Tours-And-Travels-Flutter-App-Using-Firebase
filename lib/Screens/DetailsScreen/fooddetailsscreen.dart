import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> foodDetails;

  const FoodDetailsScreen({super.key, required this.foodDetails});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
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
        title: Text(widget.foodDetails['foodName']),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
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
                  widget
                      .foodDetails['imageUrl'], // Use imageUrl from passed data
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  _buildDetailRow('Food Name', widget.foodDetails['foodName'],
                      Colors.black, Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow(
                      'Food Timing',
                      widget.foodDetails['foodTiming'],
                      Colors.black,
                      Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow(
                      'Food Delivery',
                      widget.foodDetails['delivery'],
                      Colors.black,
                      Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow('Location', widget.foodDetails['location'],
                      Colors.black, Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow(
                      'Number of People',
                      widget.foodDetails['noOfPeople'].toString(),
                      Colors.black,
                      Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow(
                      'Phone Number',
                      widget.foodDetails['phoneNumber'],
                      Colors.black,
                      Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDetailRow(
                      'Price',
                      widget.foodDetails['price'].toString(),
                      Colors.black,
                      Colors.green),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
                width: 150.w,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchPhone(
                      widget.foodDetails['phoneNumber'],
                    );
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
                      fontFamily: 'CinzelDecorative-Regular.ttf',
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

  Widget _buildDetailRow(
      String heading, String? data, Color headingColor, Color dataColor) {
    IconData iconData;
    switch (heading) {
      case 'Food Name':
        iconData = Icons.fastfood;
        break;
      case 'Food Timing':
        iconData = Icons.access_time;
        break;
      case 'Food Delivery':
        iconData = Icons.local_shipping;
        break;
      case 'Location':
        iconData = Icons.location_on;
        break;
      case 'Number of People':
        iconData = Icons.group;
        break;
      case 'Phone Number':
        iconData = Icons.phone;
        break;
      case 'Price':
        iconData = Icons.attach_money;
        break;
      default:
        iconData = Icons.error;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            iconData,
            color: headingColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          heading,
          style: TextStyle(
            fontSize: 16.sp,
            color: headingColor,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              data ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                color: dataColor,
                fontFamily: 'Urbanist-VariableFont_wght.ttf',
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
