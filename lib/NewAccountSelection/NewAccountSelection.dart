import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/FoodCatagories/ChooseFood.dart';
import 'package:solosavour/Room/RoomDataUploading.dart';
import 'package:solosavour/Screens/DataUploadingScreen/cardatauploadingscreen.dart';
import 'package:solosavour/StuffCatagories/ChooseStuff/choosestuff.dart';

class NewAccountSelection extends StatelessWidget {
  const NewAccountSelection({
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
              "Register yourself please!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
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
                            child: const ChoosingFood()));
                  },
                  label: 'Food',
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
                            child: const ChoosingStuff()));
                  },
                  label: 'Stuff',
                  icon: Icons.shopping_bag,
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
                            child: const CarUploadingData()));
                  },
                  label: 'Ride',
                  icon: Icons.directions_car,
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
                            child: const RoomUploadingData()));
                  },
                  label: 'Room',
                  icon: Icons.hotel,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 250,
            left: 15,
            child: Text(
              "Lets SoloSavour give you best favour!",
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
