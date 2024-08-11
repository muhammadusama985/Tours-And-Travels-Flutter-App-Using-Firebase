import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingPageView extends StatefulWidget {
  const BoardingPageView({super.key});

  @override
  _BoardingPageViewState createState() => _BoardingPageViewState();
}

class _BoardingPageViewState extends State<BoardingPageView> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  buildPage(
                    image: 'assets/images/Onboarding1.png',
                    title: 'Embark: Your Journey Begins',
                    description:
                        "Embark on a journey of discovery and exploration with our app. Whether you're planning a solo trip or embarking on a group adventure.",
                  ),
                  buildPage(
                    image: 'assets/images/onboarding2.png',
                    title: 'Flavors Around the World',
                    description:
                        "Indulge your senses and treat your taste buds to a world of culinary delights. From local street food to gourmet cuisine",
                  ),
                  buildPage(
                    image: 'assets/images/onboarding3.png',
                    title: 'Drive Easy: Seamless Travel',
                    description:
                        'Travel with peace of mind knowing that your transportation needs are taken care of. With our app, you can easily book rental cars, ',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                3,
                (int index) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.white : Colors.grey,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 200.w,
              height: 35.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.animateToPage(
                      _currentPage + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade,
                    //         child: const MyStackScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.cyan.shade400, width: 2),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  _currentPage == 2 ? 'Get Started' : 'Next',
                  style: TextStyle(
                    color: Colors.cyan.shade400,
                    fontFamily: 'Urbanist-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(22),
              fontFamily: 'Roboto-Black.ttf',
            ),
          ),
          SizedBox(height: 50.h),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist-VariableFont_wght.ttf',
                fontSize: ScreenUtil().setSp(17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
