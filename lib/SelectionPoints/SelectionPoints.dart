import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/NewRegister/NewLogin.dart';
import 'package:solosavour/animation/animation.dart';
import 'package:solosavour/bocome%20a%20member/loginSignupScreen.dart';

class SelectionPoints extends StatelessWidget {
  const SelectionPoints({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/newsplash.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 10,
          child: AnimatedContainerWithDelay(
            delay: const Duration(milliseconds: 1400),
            child: Text(
              "Discover\nThe best lovely\nplaces !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontFamily: "Urbanist-VariableFont_wght.ttf",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 250,
          left: 10,
          child: AnimatedContainerWithDelay(
            delay: const Duration(milliseconds: 1600),
            child: Text(
              "Lets SoloSavour guide you !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: "Urbanist-VariableFont_wght.ttf",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 250.w,
                  child: AnimatedContainerWithDelay(
                    delay: const Duration(milliseconds: 2300),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const NewLoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      // Add icon
                      label: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(
                        Icons.join_right_outlined,
                        color: Colors.white,
                      ), // Add text
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 250.w,
                  child: AnimatedContainerWithDelay(
                    delay: const Duration(milliseconds: 2500),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const loginSignupScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      // Add icon
                      label: Text(
                        'Service Provider',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ), // Add text
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
