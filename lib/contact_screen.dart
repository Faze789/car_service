import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class ContactScreen extends StatelessWidget {
   ContactScreen({super.key});
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

  // Map of contact data
  final Map<String, String> contactData = const {
    'business_name': 'Emirate Facilities',
    'owner': 'Umar Nawaz',
    'email': 'umar111@gmail.com',
    'contact': '00971567530535',
    'address': 'Abu Dhabi, UAE',
    'whatsapp': '+971567530535', // Changed to remove space for WhatsApp URL
    'working_hours': 'Daily: 8:00 AM - 10:00 PM',
    'website': 'www.emiratefacilities.ae',
  };

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp() async {
    final whatsappNumber = contactData['whatsapp']!.replaceAll(' ', '');
    final message = 'Hello! I found your contact through the Emirates Facilities app.';
    final whatsappUrl = 'https://wa.me/$whatsappNumber?text=${Uri.encodeFull(message)}';
    
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Fallback
      final fallbackUrl = 'https://api.whatsapp.com/send?phone=$whatsappNumber&text=${Uri.encodeFull(message)}';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      } else {
        // Show error
        Fluttertoast.showToast(
  msg: "Could not open WhatsApp",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
);

      }
    }
  }



  

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/tour');
            },
            icon: const Icon(Icons.home),
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.phone_in_talk,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    contactData['business_name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${contactData['owner']!}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            
            // Contact Information Cards
            const Text(
              'Contact Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
         
            _buildContactCard(
              context: context,
              icon: Icons.phone_android,
              title: 'WhatsApp',
              value: contactData['whatsapp']!,
              color: Colors.green,
              onPressed: _launchWhatsApp,
            ),
            
          
          
           
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            
            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _launchWhatsApp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.message, color: Colors.white),
                    label: const Text(
                      'WhatsApp',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              
              ],
            ),
            
            const SizedBox(height: 10),
            
            
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            
            // Map/Location Section
            const Text(
              'Our Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            
           
            
            const SizedBox(height: 30),
            
            // Social Media
            const Text(
              'Follow Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Add Facebook functionality
                    launch('https://facebook.com/emiratesfacilities');
                  },
                  icon: const Icon(Icons.facebook, color: Colors.blue, size: 40),
                ),
                IconButton(
                  onPressed: () {
                    // Add Instagram functionality
                    launch('https://instagram.com/emiratesfacilities');
                  },
                  icon: const Icon(Icons.camera_alt, color: Colors.pink, size: 40),
                ),
                IconButton(
                  onPressed: () {
                    // Add YouTube functionality
                    launch('https://youtube.com/emiratesfacilities');
                  },
                  icon: const Icon(Icons.play_arrow, color: Colors.red, size: 40),
                ),
                IconButton(
                  onPressed: _launchWhatsApp,
                  icon: const Icon(Icons.message, color: Colors.green, size: 40),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    Future<void> Function()? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}