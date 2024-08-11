import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class StuffDetailView extends StatefulWidget {
  final Map<String, dynamic> gadget;

  const StuffDetailView({super.key, required this.gadget});

  @override
  State<StuffDetailView> createState() => _StuffDetailViewState();
}

class _StuffDetailViewState extends State<StuffDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
    final stuffName = widget.gadget['stuffName'] as String?;
    final stuffLocation = widget.gadget['stuffLocation'] as String?;
    final stuffPrice = widget.gadget['stuffPrice'] as String?;
    final bookingTiming = widget.gadget['bookingTiming'] as String?;
    final returningTiming = widget.gadget['returningTiming'] as String?;
    final stuffQuality = widget.gadget['stuffQuality'] as String?;
    final stuffQuantities = widget.gadget['stuffQuantities'] as String?;
    final stuffImageUrl = widget.gadget['stuffImageUrl'] as String?;
    final userImageUrl = widget.gadget['userImageUrl'] as String?;
    final phoneNumber = widget.gadget['phoneNumber'] as String?;
    final firstName = widget.gadget['firstName'] as String?;
    final timestamp = (widget.gadget['timestamp'] as Timestamp).toDate();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    stuffImageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Stuff: $stuffName',
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
                        'Stuff Location: $stuffLocation',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Price: Rs $stuffPrice',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
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
                    // Add your description widget here
                    FadeTransition(
                      opacity: _animation,
                      child: SizedBox(
                        height: 200.h,
                        width: 350.w,
                        child: Column(
                          children: [
                            RoomDetailRow(
                              icon: Icons.timelapse,
                              label: 'Booking Timing: ',
                              value: '$bookingTiming',
                            ),
                            RoomDetailRow(
                              icon: Icons.time_to_leave_outlined,
                              label: 'Returning Timing: ',
                              value: '$returningTiming',
                            ),
                            RoomDetailRow(
                              icon: Icons.numbers,
                              label: 'Stuff Quality: ',
                              value: '$stuffQuality',
                            ),
                            RoomDetailRow(
                              icon: Icons.data_thresholding,
                              label: 'Stuff Quantities:',
                              value: ' $stuffQuantities',
                            ),
                            RoomDetailRow(
                              icon: Icons.phone,
                              label: 'Phone Number: ',
                              value: '$phoneNumber',
                            ),
                            RoomDetailRow(
                              icon: Icons.timelapse,
                              label: 'Timestamp: ',
                              value: '$timestamp',
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  userImageUrl ?? '',
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
                                    '$firstName',
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
                            SizedBox(width: 70.h),
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
                            launchPhone(phoneNumber ?? '');
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
      ),
    );
  }
}

class RoomDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const RoomDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
