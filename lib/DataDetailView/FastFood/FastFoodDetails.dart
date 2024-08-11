import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FastFoodDetails extends StatefulWidget {
  final Map<String, dynamic> foodData;

  const FastFoodDetails({super.key, required this.foodData});

  @override
  State<FastFoodDetails> createState() => _FastFoodDetailsState();
}

class _FastFoodDetailsState extends State<FastFoodDetails>
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

  Widget _buildDetailItem(String heading, String data, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: Colors.black,
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Text(
          heading,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Urbanist-VariableFont_wght.ttf',
          ),
        ),
        SizedBox(width: 10.w),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.foodData['foodImageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Food Name: ${widget.foodData['foodName']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Location: ${widget.foodData['location']}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Price: RS ${widget.foodData['price']}',
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
                    FadeTransition(
                      opacity: _animation,
                      child: SizedBox(
                        height: 150.h,
                        width: 350.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _buildDetailItem(
                              'Food Name:',
                              widget.foodData['foodName'],
                              Icons.food_bank,
                            ),
                            _buildDetailItem(
                              'People can eat:',
                              widget.foodData['noOfPeople'],
                              Icons.group,
                            ),
                            _buildDetailItem(
                              'Price:',
                              'Rs ${widget.foodData['price']}',
                              Icons.attach_money,
                            ),
                            _buildDetailItem(
                              'Location:',
                              widget.foodData['location'],
                              Icons.location_on,
                            ),
                            _buildDetailItem(
                              'Food Timing:',
                              widget.foodData['foodTiming'],
                              Icons.access_time,
                            ),
                            _buildDetailItem(
                              'Delivery:',
                              widget.foodData['delivery'],
                              Icons.delivery_dining,
                            ),
                            _buildDetailItem(
                              'Phone Number:',
                              widget.foodData['phoneNumber'],
                              Icons.phone,
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
                                  widget.foodData['userImageUrl'],
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
                                    widget.foodData['firstName'],
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
                            launchPhone(widget.foodData['phoneNumber'] ?? '');
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
