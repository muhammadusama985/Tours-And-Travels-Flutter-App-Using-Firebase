import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class electronics1 extends StatefulWidget {
  const electronics1({Key? key}) : super(key: key);

  @override
  _electronics1 createState() => _electronics1();
}

class _electronics1 extends State<electronics1> {
  late Stream<QuerySnapshot> _stream;
  late String _currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUserId = user!.uid;
      _stream = FirebaseFirestore.instance
          .collection('Electronics')
          .where('userId', isEqualTo: _currentUserId)
          .snapshots();
    });
  }

  Future<void> _deleteGadget(String documentId) async {
    await FirebaseFirestore.instance
        .collection('Electronics')
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 228, 235),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                final gadget = gadgets[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Deletion"),
                          content: const Text(
                              "Would you like to delete this gadget?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteGadget(gadgets[index].id);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: buildGadgetCard(gadget),
                );
              },
            );
          },
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
              width: 100,
              height: 100,
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
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stuffName ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    stuffLocation ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Price: ${stuffPrice ?? ''}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Booking Timing: ${bookingTiming ?? ''}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Returning Timing: ${returningTiming ?? ''}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
