import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/StuffCatagories/StuffDetailView/StuffDetailView.dart';

class ViewTracking extends StatefulWidget {
  const ViewTracking({super.key});

  @override
  _ViewTrackingState createState() => _ViewTrackingState();
}

class _ViewTrackingState extends State<ViewTracking> {
  final TextEditingController _locationController = TextEditingController();
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Tracking').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 243, 220),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: 'Search by location...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                ElevatedButton(
                  onPressed: () {
                    String location = _locationController.text.trim();
                    if (location.isNotEmpty) {
                      setState(() {
                        _stream = FirebaseFirestore.instance
                            .collection('Tracking')
                            .where('stuffLocation', isEqualTo: location)
                            .snapshots();
                      });
                    } else {
                      setState(() {
                        _stream = FirebaseFirestore.instance
                            .collection('Tracking')
                            .snapshots();
                      });
                    }
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final gadgets = snapshot.data?.docs ?? [];

                  return ListView.builder(
                    itemCount: gadgets.length,
                    itemBuilder: (context, index) {
                      final gadget =
                          gadgets[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StuffDetailView(gadget: gadget),
                            ),
                          );
                        },
                        child: buildGadgetCard(gadget),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGadgetCard(Map<String, dynamic> gadget) {
    final stuffName = gadget['stuffName'] as String?;
    final stuffLocation = gadget['stuffLocation'] as String?;
    final stuffPrice = gadget['stuffPrice'] as String?;
    final bookingTiming = gadget['bookingTiming'] as String?;
    final returningTiming = gadget['returningTiming'] as String?;
    final stuffImageUrl = gadget['stuffImageUrl'] as String?;

    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  stuffImageUrl ?? '', // Provide default value if null
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stuffName ?? '',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    stuffLocation ?? '',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                    ),
                  ),
                  Text(
                    'Price: ${stuffPrice ?? ''}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Booking Timing: ${bookingTiming ?? ''}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Returning Timing: ${returningTiming ?? ''}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Urbanist-VariableFont_wght.ttf",
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
