import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewScreen extends StatefulWidget {
  final DocumentSnapshot ride;

  const DetailViewScreen({
    super.key,
    required this.ride,
  });

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
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
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FadeTransition(
              opacity: _animation,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.ride['carImageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      widget.ride['carName'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      "Verified Driver By Pakistan",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Rs ${widget.ride['price']}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      "Description:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Container(
                      color: Colors.white,
                      height: 200.h,
                      width: 350.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDetailItem('Car Name', widget.ride['carName'],
                              Icons.directions_car),
                          _buildDetailItem(
                              'Car Number',
                              widget.ride['carNumber'],
                              Icons.confirmation_number),
                          _buildDetailItem('Drop Point',
                              widget.ride['dropPoint'], Icons.pin_drop),
                          _buildDetailItem('Pickup Point',
                              widget.ride['pickupPoint'], Icons.location_on),
                          _buildDetailItem('Price Rs', widget.ride['price'],
                              Icons.attach_money),
                          _buildDetailItem('Seats Available',
                              widget.ride['seatsAvailable'], Icons.event_seat),
                          _buildDetailItem('Phone Number',
                              widget.ride['phoneNumber'], Icons.phone),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Container(
                      height: 80.h,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.ride[
                                    'userImageUrl'], // Assuming 'userImageUrl' is the key for user's profile image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.h),
                          SizedBox(
                            height: 50.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Owner',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                  ),
                                ),
                                Text(
                                  widget.ride['firstName'],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 120.h),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: const Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: SizedBox(
                      height: 50.h,
                      width: 320.w,
                      child: ElevatedButton(
                        onPressed: () {
                          launchPhone(widget.ride['phoneNumber']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Call The Owner',
                              style: TextStyle(
                                fontSize: 19.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            color: Colors.blue,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
      ],
    );
  }
}
