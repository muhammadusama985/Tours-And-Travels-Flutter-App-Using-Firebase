import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solosavour/NewDataScreens/RideData.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ridedata1 extends StatefulWidget {
  const ridedata1({super.key});

  @override
  _RideDataScreenState createState() => _RideDataScreenState();
}

class _RideDataScreenState extends State<ridedata1> {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("assets/videos/map.mp4");

  ChewieController? chewieController;

  final TextEditingController _pickPointController = TextEditingController();
  final TextEditingController _dropPointController = TextEditingController();

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 9 / 20,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Expanded(
            child: Chewie(
              controller: chewieController!,
            ),
          ),
          Container(color: Colors.black54),
          Positioned(
            top: 70,
            left: 10,
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    ''.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 0.2,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      letterSpacing: 0.2,
                      wordSpacing: 0.2,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 100), // Increased the height of the SizedBox
                  // Pick-up Point TextField
                  TextField(
                    controller: _pickPointController,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      hintText: 'Pick-up Point',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Drop-off Point TextField
                  TextField(
                    controller: _dropPointController,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      hintText: 'Drop-off Point',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        _filterItems(context);
                      },
                      child: Text(
                        'Find Ride',
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _filterItems(BuildContext context) async {
    final String pickPoint = _pickPointController.text.trim();
    final String dropPoint = _dropPointController.text.trim();

    if (pickPoint.isNotEmpty && dropPoint.isNotEmpty) {
      // Navigate to RideDataScreen with pickup and drop points
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RideDataScreen(
            pickPoint: pickPoint,
            dropPoint: dropPoint,
          ),
        ),
      );
    } else {
      // Show error message if pickup or drop point is empty
      Fluttertoast.showToast(
        msg: "Please enter pickup and drop points",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
