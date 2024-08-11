import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/AllUserServices/Trekking1.dart';
import 'package:solosavour/AllUserServices/chinese1.dart';
import 'package:solosavour/AllUserServices/clothes1.dart';
import 'package:solosavour/AllUserServices/desi1.dart';
import 'package:solosavour/AllUserServices/electronics1.dart';
import 'package:solosavour/AllUserServices/fast1.dart';
import 'package:solosavour/AllUserServices/gadgets1.dart';
import 'package:solosavour/AllUserServices/ride1.dart';
import 'package:solosavour/AllUserServices/room1.dart';
import 'package:solosavour/AllUserServices/tradition1.dart';

class UserAllServices extends StatefulWidget {
  const UserAllServices({Key? key});

  @override
  _UserAllServicesState createState() => _UserAllServicesState();
}

class _UserAllServicesState extends State<UserAllServices>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.blue,
        title: Text(
          'Food Categories',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            letterSpacing: 1,
            fontFamily: "Urbanist-VariableFont_wght.ttf",
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.restaurant),
              text: 'Desi',
            ),
            Tab(
              icon: Icon(Icons.fastfood),
              text: 'Fast',
            ),
            Tab(
              icon: Icon(Icons.local_pizza),
              text: 'Chinese',
            ),
            Tab(
              icon: Icon(Icons.local_dining),
              text: 'Traditional',
            ),
            Tab(
              icon: Icon(Icons.motorcycle),
              text: 'Rides',
            ),
            Tab(
              icon: Icon(Icons.home),
              text: 'Rooms',
            ),
            Tab(
              icon: Icon(Icons.phone_android),
              text: 'Gadgets',
            ),
            Tab(
              icon: Icon(Icons.location_on),
              text: 'Trekking',
            ),
            Tab(
              icon: Icon(Icons.laptop),
              text: 'Electronics',
            ),
            Tab(
              icon: Icon(Icons.shopping_bag),
              text: 'Clothes',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          desi1(),
          fast1(),
          chinese1(),
          tradition1(),
          ride1(),
          room1(),
          gadget1(),
          trekking1(),
          electronics1(),
          clothes1(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
