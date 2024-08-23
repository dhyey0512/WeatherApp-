import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/splash.dart';
import 'dart:convert';

import 'package:weatherapp/ui_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var city = "Pune";
  var fdata = TextEditingController(text: "Pune");
  var temp = "";
  final apiK = "d6f597fdbf6f80300bcaf3933c5251c9";
  var data;
  var name;
  var icon;
  var description;
  var humidity;
  var windSpeed;
  var temperature;
  var image;
  var width;
  var height;
  var feelsLike;
  bool isHovered = false;
  Future<void> fetchData({required var city}) async {
    width = 700;
    height = 700;
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${city.toString()}&appid=${apiK.toString()}"));

    image =
        "https://images.unsplash.com/photo-1461988320302-91bde64fc8e4?ixid=2yJhcHBfaWQiOjEyMDd9";

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      name = data['name']!.toString();
      icon = data['weather'][0]['icon'].toString();
      description = data['weather']![0]['description']!.toString();
      temperature = (data['main']['temp'] - 273.15).toStringAsFixed(0);
      humidity = data['main']!['humidity']!.toString();
      windSpeed = data['wind']['speed']!.toString();
      feelsLike = (data['main']['feels_like'] - 273.15).toStringAsFixed(0);
      this.city = name;
      setState(() {
        temp = "$temperature°C";
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    fetchData(city: this.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(fit: StackFit.expand, children: [
          Image.network(
            image ??
                "https://images.unsplash.com/photo-1461988320302-91bde64fc8e4?ixid=2yJhcHBfaWQiOjEyMDd9",
            fit: BoxFit.cover,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 350,
                height: 370,
                color: Color.fromARGB(191, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, top: 30, bottom: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 270,
                            child: MouseRegion(
                              onEnter: (event) => setState(() {
                                isHovered = true;
                              }),
                              onExit: (event) => setState(() {
                                isHovered = false;
                              }),
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 2),
                                controller: fdata,
                                decoration: InputDecoration(
                                  hintText: "Enter city",
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      letterSpacing: 2),
                                  contentPadding:
                                      EdgeInsets.only(left: 11, right: 11),
                                  filled: true,
                                  fillColor: !isHovered
                                      ? const Color.fromARGB(214, 86, 85, 85)
                                      : const Color.fromARGB(213, 60, 59, 59),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 7, 206, 241),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (fdata.text != "") {
                                  fetchData(city: fdata.text);
                                  print(feelsLike);
                                }
                              });
                            },
                            child: const CircleAvatar(
                              radius: 23,
                              child: Icon(Icons.search),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          dataText(value: "Weather in $city"),
                          dataText(value: "$temp", fontSize: 32, mt: 20),
                          Row(
                            children: [
                              if (icon != null)
                                Image.network(
                                  'https://openweathermap.org/img/wn/${icon.toString()}.png',
                                  color: Colors.blue,
                                  scale: 0.92,
                                ),
                              Expanded(
                                child: dataText(
                                    value: description.toString().toUpperCase(),
                                    fontSize: 17,
                                    ml: 5,
                                    mr: 12),
                              ),
                            ],
                          ),
                          dataText(
                              value: "Humidity : $humidity%",
                              fontSize: 17,
                              mt: 5),
                          dataText(
                              value: "Wind Speed : $windSpeed Km/hr",
                              fontSize: 17,
                              mt: 12),
                          dataText(
                              value: "It Feels Like : $feelsLike°C",
                              fontSize: 17,
                              mt: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
