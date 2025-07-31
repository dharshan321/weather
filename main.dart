import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app2/wigets/main_Wigets.dart';

void main() {
  runApp(MyApp());
}

Future<WeatherInfo> fetchWeather() async {
  final zipcode = '600001'; // Example ZIP code, replace with your own
  final apikey = 'c13c2e94ca20ffdf9e66a6220587d610'; 
  final requesturl =
      'http://api.openweathermap.org/data/2.5/weather?zip=$zipcode,in&units=metric&appid=$apikey';
  final response = await http.get(Uri.parse(requesturl));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}

class WeatherInfo {
  final dynamic location;
  final dynamic temp;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic weather;
  final dynamic humidity;
  final dynamic windSpeed;

  WeatherInfo({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['main'], // corrected key
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: Scaffold(
        body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return MainWidget(
                location: data.location,
                temp: data.temp,
                tempMin: data.tempMin,
                tempMax: data.tempMax,
                humidity: data.humidity,
                windSpeed: data.windSpeed,
                weather: data.weather,
              );
            } else {
              return Center(child: Text("No data available."));
            }
          },
        ),
      ),
    );
  }
}
