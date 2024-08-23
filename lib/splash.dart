import 'dart:async';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchData(); // Call your fetchData method here
  }

  Future<void> fetchData() async {
    // Replace this with your actual data fetching logic
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.sunny_snowing,
                size: 100,
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(11.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Dhyey's Weather App",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
