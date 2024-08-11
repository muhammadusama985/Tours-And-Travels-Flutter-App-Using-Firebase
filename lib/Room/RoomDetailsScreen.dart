import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetails extends StatefulWidget {
  final Map<String, dynamic> roomData;

  const RoomDetails({super.key, required this.roomData});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails>
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.roomData['roomImageUrl'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
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
                      widget.roomData['roomName'] ?? '',
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
                      widget.roomData['roomAddress'] ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Room Price: Rs ${widget.roomData['roomPrice']}',
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
                    child: Container(
                      color: Colors.white,
                      height: 200.h,
                      width: 350.w,
                      child: Column(
                        children: [
                          RoomDetailRow(
                              icon: Icons.confirmation_number,
                              label: 'Room Number',
                              value: widget.roomData['roomNumber'] ?? ''),
                          RoomDetailRow(
                              icon: Icons.event_seat,
                              label: 'Seats',
                              value: '${widget.roomData['seats']}'),
                          RoomDetailRow(
                              icon: Icons.hotel,
                              label: 'Number of Rooms',
                              value: '${widget.roomData['numOfRooms']}'),
                          RoomDetailRow(
                              icon: Icons.event,
                              label: 'Check In',
                              value: widget.roomData['checkIn'] ?? ''),
                          RoomDetailRow(
                              icon: Icons.event_busy,
                              label: 'Check Out',
                              value: widget.roomData['checkOut'] ?? ''),
                          RoomDetailRow(
                              icon: Icons.info,
                              label: 'Room Condition',
                              value: widget.roomData['roomCondition'] ?? ''),
                          RoomDetailRow(
                              icon: Icons.phone,
                              label: 'Owner Number',
                              value: widget.roomData['roomOwnerNumber'] ?? ''),
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
                                widget.roomData['userImageUrl'],
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
                                  widget.roomData['firstName'] ?? '',
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
                          launchPhone(widget.roomData['roomOwnerNumber'] ?? '');
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
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
