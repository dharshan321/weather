import 'package:flutter/material.dart';
import 'package:wheather_app2/wigets/wearth_tile.dart';

class MainWidget extends StatelessWidget {
  final dynamic location;
  final dynamic temp;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic weather;
  final dynamic humidity;
  final dynamic windSpeed;

  MainWidget({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Center(
            child: Text(
              '$location',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            '$temp°C',
            style: TextStyle(fontSize: 40, color: Colors.purple),
          ),
        ),
        Text(
          'High of $tempMax°C | Low of $tempMin°C',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff9e9e9e),
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                WeatherTile(
                  icon: Icons.thermostat_auto_outlined,
                  title: "Temperature",
                  subtitle: "$temp°C",
                ),
                WeatherTile(
                  icon: Icons.cloud_outlined,
                  title: "Weather",
                  subtitle: "$weather",
                ),
                WeatherTile(
                  icon: Icons.water_drop_outlined,
                  title: "Humidity",
                  subtitle: "$humidity%",
                ),
                WeatherTile(
                  icon: Icons.waves_outlined,
                  title: "Wind Speed",
                  subtitle: "$windSpeed m/s",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
