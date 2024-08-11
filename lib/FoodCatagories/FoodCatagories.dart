import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/DataDetailView/ChineseFood/ChineseFoodView.dart';
import 'package:solosavour/DataDetailView/DesiFood/DesiFood.dart';
import 'package:solosavour/DataDetailView/FastFood/FastFoodData.dart';
import 'package:solosavour/DataDetailView/TradtionalFood/TraditionalFoodView.dart';

class FoodCatagories extends StatefulWidget {
  const FoodCatagories({super.key});

  @override
  _FoodCatagoriesState createState() => _FoodCatagoriesState();
}

class _FoodCatagoriesState extends State<FoodCatagories>
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
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.restaurant),
              text: 'Desi ',
            ),
            Tab(
              icon: Icon(Icons.fastfood),
              text: 'Fast ',
            ),
            Tab(
              icon: Icon(Icons.local_pizza),
              text: 'Chinese ',
            ),
            Tab(
              icon: Icon(Icons.local_dining),
              text: 'Traditional',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DesiFoodView(),
          FastFoodView(),
          ChineseFoodView(),
          TraditionalFoodView(),
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
