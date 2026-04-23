import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
         IconButton(onPressed: () {
            context.go('/tour');
          }, icon: Icon(Icons.home) , color: Colors.white,)
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Abu Dhabi Desert Safari Adventures',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We are the leading desert safari provider in Abu Dhabi...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            // Add more content here
          ],
        ),
      ),
    );
  }
}