import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/Screens/DetailsScreen/fooddetailsscreen.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({
    super.key,
  });

  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FoodData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailsScreen(
                        foodDetails: data,
                      ),
                    ),
                  );
                },
                child: FoodGridItem(
                  foodName: data['foodName'] ?? 'Unknown',
                  phoneNumber: data['phoneNumber'] ?? 'Unknown',
                  imageUrl: data['imageUrl'],
                  index: index + 1,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FoodGridItem extends StatelessWidget {
  final String foodName;
  final String phoneNumber;
  final String? imageUrl;
  final int index;

  const FoodGridItem({
    super.key,
    required this.foodName,
    required this.phoneNumber,
    this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imageUrl != null && imageUrl!.isNotEmpty)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl!),
            ),
          const SizedBox(height: 10),
          Text(
            foodName,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Urbanist-VariableFont_wght.ttf',
            ),
          ),
          Text(
            phoneNumber,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamily: 'Urbanist-VariableFont_wght.ttf',
            ),
          ),
        ],
      ),
    );
  }
}
