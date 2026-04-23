import 'package:flutter/material.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Our Tours',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          'All Tour Packages',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}