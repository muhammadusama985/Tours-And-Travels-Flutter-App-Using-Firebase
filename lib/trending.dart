import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solosavour/weaterapi.dart';
import 'package:weather/weather.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({Key? key}) : super(key: key);

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final weather = await _wf.currentWeatherByCityName("Haripur");
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _weather!.areaName ?? "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${_weather!.temperature?.celsius?.toStringAsFixed(0)}° C",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _dateTimeInfo(),
                  SizedBox(height: 20),
                  _weatherIcon(),
                  SizedBox(height: 20),
                  _extraInfo(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Latest Trending',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildCard(
            image: AssetImage('assets/images/image11.jpg'),
            description:
                " Machu Picchu is an ancient Incan citadel set high in the Andes Mountains of Peru. It's renowned for its sophisticated dry-stone walls, intriguing architecture, and stunning panoramic views.",
          ),
          SizedBox(height: 20),
          _buildCard(
            image: AssetImage('assets/images/image22.jpg'),
            description:
                "The Great Barrier Reef is the world's largest coral reef system, composed of over 2,900 individual reefs and 900 islands stretching over 2,300 kilometers. It's a UNESCO World Heritage Site and home to a diverse range of marine life. ",
          ),
          SizedBox(height: 20),
          _buildCard(
            image: AssetImage('assets/images/image33.jpg'),
            description:
                "Discover breathtaking landscapes, vibrant cultures, and rich histories at our curated tour destinations. Embark on unforgettable journeys filled with adventure, exploration, and moments to treasure forever",
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required AssetImage image, required String description}) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
              image: image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 5),
            Text(
              DateFormat("d.M.y").format(now),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Center(
      child: Image.network(
        "http://openweathermap.org/img/wn/${_weather!.weatherIcon}@2x.png",
        height: 100,
      ),
    );
  }

  Widget _extraInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow("Max", "${_weather!.tempMax?.celsius?.toStringAsFixed(0)}° C"),
        _infoRow("Min", "${_weather!.tempMin?.celsius?.toStringAsFixed(0)}° C"),
        _infoRow("Wind", "${_weather!.windSpeed?.toStringAsFixed(0)} m/s"),
        _infoRow("Humidity", "${_weather!.humidity?.toStringAsFixed(0)}%"),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
