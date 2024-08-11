import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/Screens/DetailsScreen/StuffDetailScreen.dart';

class StuffListScreen extends StatefulWidget {
  const StuffListScreen({super.key});

  @override
  State<StuffListScreen> createState() => _StuffListScreenState();
}

class _StuffListScreenState extends State<StuffListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('StuffData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
              Map<String, dynamic>? data =
                  document.data() as Map<String, dynamic>?;

              if (data == null ||
                  data['stuffName'] == null ||
                  data['stuffPrice'] == null ||
                  data['imageUrl'] == null) {
                return const SizedBox(); // If any required field is null, just return an empty SizedBox
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StuffDetailsScreen(
                        stuffData: data,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data['imageUrl']),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data['stuffName'],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Urbanist-VariableFont_wght.ttf',
                        ),
                      ),
                      Text(
                        'Price: Rs ${data['stuffPrice']}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Urbanist-VariableFont_wght.ttf',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
