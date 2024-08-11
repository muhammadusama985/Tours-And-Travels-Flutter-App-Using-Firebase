import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/StuffCatagories/ViewStuffData.dart/ViewClothes.dart';
import 'package:solosavour/StuffCatagories/ViewStuffData.dart/ViewElectronics.dart';
import 'package:solosavour/StuffCatagories/ViewStuffData.dart/ViewGadgets.dart';
import 'package:solosavour/StuffCatagories/ViewStuffData.dart/ViewTracking.dart';

class StuffCatagories extends StatefulWidget {
  const StuffCatagories({super.key});

  @override
  _StuffCatagoriesState createState() => _StuffCatagoriesState();
}

class _StuffCatagoriesState extends State<StuffCatagories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.blue,
        title: Text(
          'Stuff Categories',
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
          indicatorColor: Colors.black,
          indicatorWeight: 5.0,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.phone_android),
              text: 'Gadgets ',
            ),
            Tab(
              icon: Icon(Icons.location_on),
              text: 'Trekking ',
            ),
            Tab(
              icon: Icon(Icons.laptop),
              text: 'Electronics ',
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
        children: const [
          ViewGadget(),
          ViewTracking(),
          ViewElectronics(),
          ViewClothes(),
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
