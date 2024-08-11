import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDetails extends StatefulWidget {
  final String foodName;
  final String location;
  final String price;
  final String foodTiming;
  final String phoneNumber;
  final String foodImageUrl;
  final String noOfPeople;
  final String delivery;
  final String firstName;
  const FoodDetails({
    required this.foodName,
    required this.location,
    required this.price,
    required this.foodTiming,
    required this.phoneNumber,
    required this.foodImageUrl,
    required this.noOfPeople,
    required this.delivery,
    required this.firstName,
    super.key,
  });

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails>
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
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.foodImageUrl,
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
                      widget.foodName,
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
                      widget.location,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Rs ${widget.price}',
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
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      height: 200.h,
                      width: 350.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsContainer(
                            heading: 'Food Name:',
                            icon: Icons.fastfood,
                            value: widget.foodName,
                          ),
                          DetailsContainer(
                            heading: 'Location:',
                            icon: Icons.location_on,
                            value: widget.location,
                          ),
                          DetailsContainer(
                            heading: 'Price:',
                            icon: Icons.attach_money,
                            value: 'Rs ${widget.price}',
                          ),
                          DetailsContainer(
                            heading: 'Food Timing:',
                            icon: Icons.access_time,
                            value: widget.foodTiming,
                          ),
                          DetailsContainer(
                            heading: 'Phone Number:',
                            icon: Icons.phone,
                            value: widget.phoneNumber,
                          ),
                          DetailsContainer(
                            heading: 'No. of People:',
                            icon: Icons.people,
                            value: widget.noOfPeople,
                          ),
                          DetailsContainer(
                            heading: 'Delivery:',
                            icon: Icons.delivery_dining,
                            value: widget.delivery,
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
                              child: Image.asset(
                                'assets/images/ali.jpeg',
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
                                  widget.firstName,
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
                        onPressed: () {},
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

class DetailsContainer extends StatelessWidget {
  final String heading;
  final IconData icon;
  final String value;

  const DetailsContainer({
    super.key,
    required this.heading,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            heading,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
