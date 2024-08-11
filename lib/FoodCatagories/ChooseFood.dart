import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/NewFoodUploading/NewUploadChineseFood.dart';
import 'package:solosavour/NewFoodUploading/NewUploadDesiFood.dart';
import 'package:solosavour/NewFoodUploading/NewUploadFastFood.dart';
import 'package:solosavour/NewFoodUploading/NewUploadTraditional.dart';

class ChoosingFood extends StatelessWidget {
  const ChoosingFood({
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
            top: 30,
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
          Positioned(
            top: 100,
            left: 50,
            child: Text(
              "Choose Catagory To Upload",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: "Urbanist-VariableFont_wght.ttf",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 60,
            child: Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const NewUploadFastFood()));
                  },
                  label: 'Fast',
                  icon: Icons.fastfood,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const NewUploadDesiFood()));
                  },
                  label: 'Desi',
                  icon: Icons.restaurant,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const NewUploadTraditionalFood()));
                  },
                  label: 'Traditional',
                  icon: Icons.local_dining,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const NewUploadChineseFood()));
                  },
                  label: 'Chinese',
                  icon: Icons.local_pizza,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 250,
            left: 15,
            child: Text(
              "Lets give people real taste !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: "Urbanist-VariableFont_wght.ttf",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 250.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Colors.white), // Add white border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set border radius here
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
