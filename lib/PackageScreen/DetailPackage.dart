import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/animation/animation.dart';

class DetailPackage extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailPackage({super.key, required this.data});

  @override
  State<DetailPackage> createState() => _DetailPackageState();
}

class _DetailPackageState extends State<DetailPackage> {
  @override
  Widget build(BuildContext context) {
    String? bookingStarting = widget.data['Booking Starting'];
    String? bookingEnding = widget.data['Booking Ending'];
    String? description = widget.data['Description'];
    String? food = widget.data['Food'];
    String? membersPerGroup = widget.data['Members in Per Group'];
    String? packageId = widget.data['Package ID'];
    String? packageName = widget.data['Package Name'];
    String? placesInPackage = widget.data['Places In package'];
    String? price = widget.data['Price'];
    String? totalDays = widget.data['Total Days'];
    String? totalGroups = widget.data['Total Groups'];
    String? totalNights = widget.data['Total Nights'];
    List<String>? imageUrls = List<String>.from(widget.data['Images'] ?? []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(context, imageUrls),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildFirstColumn(
                      bookingStarting,
                      bookingEnding,
                      totalGroups,
                      food,
                      price,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildSecondColumn(
                      packageId,
                      placesInPackage,
                      totalDays,
                      totalNights,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 2500),
                  child: Text(
                    "Description :",
                    style: TextStyle(
                        fontSize: 19.sp,
                        color: Colors.black,
                        fontFamily: "Urbanist-VariableFont_wght.ttf",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              height: 100.h,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 2600),
                  child: Text(
                    description ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        AnimatedContainerWithDelay(
                          delay: const Duration(milliseconds: 2600),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: price,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                "Urbanist-VariableFont_wght.ttf",
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '/Rs',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                "Urbanist-VariableFont_wght.ttf",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 150.w,
                          child: AnimatedContainerWithDelay(
                            delay: const Duration(milliseconds: 2800),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildHeader(BuildContext context, List<String>? imageUrls) {
    return Stack(
      children: [
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.overlay,
              ),
              child: imageUrls != null && imageUrls.isNotEmpty
                  ? Image.network(
                      imageUrls.first,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const Positioned(
          top: 30,
          right: 20,
          child: AnimatedContainerWithDelay(
            delay: Duration(milliseconds: 1300),
            child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/applogo.png'),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: AnimatedContainerWithDelay(
            delay: const Duration(milliseconds: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data['Package Name'] ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: "Urbanist-VariableFont_wght.ttf",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/Packageicon/rating.png',
                      width: 300,
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstColumn(
    String? bookingStarting,
    String? bookingEnding,
    String? totalGroups,
    String? food,
    String? price,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 1300),
          child: _buildDetailItem(
            'assets/images/Packageicon/bookstart.png',
            'Booking Start',
            bookingStarting,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 1500),
          child: _buildDetailItem(
            'assets/images/Packageicon/bookend.png',
            'Booking End',
            bookingEnding,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 1700),
          child: _buildDetailItem(
            'assets/images/Packageicon/group.png',
            'Total Group',
            totalGroups,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 1900),
          child: _buildDetailItem(
            'assets/images/Packageicon/food.png',
            'Food',
            food,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 2100),
          child: _buildDetailItem(
            'assets/images/Packageicon/rs.png',
            'Price',
            price,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondColumn(
    String? packageId,
    String? placesInPackage,
    String? totalDays,
    String? totalNights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 2300),
          child: _buildDetailItem(
            'assets/images/Packageicon/comments.png',
            'Package ID',
            packageId,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 2500),
          child: _buildDetailItem(
            'assets/images/Packageicon/places.png',
            'Places In package',
            placesInPackage,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 2700),
          child: _buildDetailItem(
            'assets/images/Packageicon/days.png',
            'Total Days',
            totalDays,
          ),
        ),
        AnimatedContainerWithDelay(
          delay: const Duration(milliseconds: 2900),
          child: _buildDetailItem(
            'assets/images/Packageicon/night.png',
            'Total Night',
            totalNights,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String imagePath, String text, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Urbanist-VariableFont_wght.ttf",
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "Urbanist-VariableFont_wght.ttf",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
