import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const RoomDetailsScreen({super.key, required this.data});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
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
        title: Text(widget.data['roomName']),
      ),
      body: Center(
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
                  widget.data['imageUrl'] ??
                      '', // Use the image URL from Firestore
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailItem(
                        heading: 'Room Name:',
                        data: widget.data['roomName'] ?? '',
                        icon: Icons.room),
                    _buildDetailItem(
                        heading: 'Room Number:',
                        data: widget.data['roomNumber'] ?? '',
                        icon: Icons.format_list_numbered),
                    _buildDetailItem(
                        heading: 'Room Address:',
                        data: widget.data['roomAddress'] ?? '',
                        icon: Icons.location_on),
                    _buildDetailItem(
                        heading: 'Check In:',
                        data: widget.data['checkIn'] ?? '',
                        icon: Icons.check),
                    _buildDetailItem(
                        heading: 'Check Out:',
                        data: widget.data['checkOut'] ?? '',
                        icon: Icons.exit_to_app),
                    _buildDetailItem(
                        heading: 'Number of rooms:',
                        data: widget.data['numOfRooms'] ?? '',
                        icon: Icons.hotel),
                    _buildDetailItem(
                        heading: 'Seats:',
                        data: widget.data['seats'] ?? '',
                        icon: Icons.event_seat),
                    _buildDetailItem(
                        heading: 'Room Size:',
                        data: widget.data['roomSize'] ?? '',
                        icon: Icons.square_foot),
                    _buildDetailItem(
                        heading: 'Room Condition:',
                        data: widget.data['roomCondition'] ?? '',
                        icon: Icons.info),
                    _buildDetailItem(
                        heading: 'Owner Phone:',
                        data: widget.data['roomOwnerNumber'] ?? '',
                        icon: Icons.phone),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 150.w,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchPhone(widget.data[
                        'roomOwnerNumber']); // Call method to launch phone call
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

  Widget _buildDetailItem(
      {required String heading, required String data, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: Colors.black,
            ),
            const SizedBox(width: 5),
            Text(
              heading,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist-VariableFont_wght.ttf',
                color: Colors.black,
              ),
            ),
          ],
        ),
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
