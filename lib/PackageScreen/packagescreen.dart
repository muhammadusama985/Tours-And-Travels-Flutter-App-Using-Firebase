import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/PackageScreen/packagerating.dart';
import 'package:solosavour/PackageScreen/DetailPackage.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final CollectionReference _packageCollection =
      FirebaseFirestore.instance.collection('Pacakge');

  late TextEditingController _searchController;
  late List<DocumentSnapshot> _packages;
  late List<DocumentSnapshot> _filteredPackages;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _packages = [];
    _filteredPackages = [];
    _fetchPackages();
  }

  void _fetchPackages() {
    _packageCollection.get().then((querySnapshot) {
      setState(() {
        _packages = querySnapshot.docs;
        _filteredPackages = _packages;
      });
    }).catchError((error) {
      print("Error fetching packages: $error");
    });
  }

  void _filterPackages(String query) {
    setState(() {
      _filteredPackages = _packages.where((package) {
        String? packageName = (package.data()
            as Map<String, dynamic>?)?['Package Name'] as String?;
        return packageName != null &&
            packageName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Packages',
            style: TextStyle(
              fontSize: 19.sp,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontFamily: "Urbanist-VariableFont_wght.ttf",
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.place_sharp,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search places',
                      border: InputBorder.none,
                    ),
                    onChanged: _filterPackages,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _filterPackages(_searchController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredPackages.isEmpty
                ? Center(
                    child: Text(
                      'No packages found.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredPackages.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = _filteredPackages[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String packageName =
                          data['Package Name'] as String? ?? '';
                      List<String> imageUrls =
                          List<String>.from(data['Images'] ?? []);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPackage(data: data),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 120.h,
                                width: 350.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.5),
                                              BlendMode.overlay),
                                          child: imageUrls.isNotEmpty
                                              ? Image.network(
                                                  imageUrls.first,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        left: 16.0,
                                        child: Row(
                                          children: [
                                            Text(
                                              packageName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                                fontFamily:
                                                    "Urbanist-VariableFont_wght.ttf",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80.w,
                                            ),
                                            const StarRating(
                                                rating: 5, size: 20.0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
