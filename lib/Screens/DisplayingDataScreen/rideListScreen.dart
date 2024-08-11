import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/Screens/DetailsScreen/ridedetailsscreen.dart';

class RideData extends StatelessWidget {
  const RideData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('RidesData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ride = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RideDetailsScreen(
                        ride: ride,
                      ),
                    ),
                  );
                },
                child: _buildRideItem(ride),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRideItem(DocumentSnapshot ride) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            ride['carName'],
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Urbanist-VariableFont_wght.ttf',
            ),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(ride['imageUrl']),
          ),
          const SizedBox(height: 10),
          Text(
            ride['phoneNumber'],
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Urbanist-VariableFont_wght.ttf',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
