import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers (removed phoneController)
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _adultsController = TextEditingController(text: '1');
  final TextEditingController _childrenController = TextEditingController(text: '0');
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  // Admin WhatsApp number
  final String _adminWhatsAppNumber = '971567530535'; // Admin number

  final List<String> _tourPackages = [
    'Abu Dhabi Desert Safari',
    'VIP Desert Safari',
    'Desert Safari With Quad Bike',
    'VIP Desert Safari + Quad Bike',
    'Overnight Desert Safari',
    '1 Seater Dune Buggy',
    '2 Seater Dune Buggy',
    '4 Seater Dune Buggy',
    'Private Desert Safari',
    'Morning Desert Safari',
    'Morning Safari + Quad Bike',
    'Private Morning Safari',
  ];

  String? _selectedPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Book Now', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_fullNameController, 'Full Name'),
              const SizedBox(height: 10),
              _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              _buildTextField(_dateController, 'Tour Date', readOnly: true, onTap: () => _selectDate(context)),
              const SizedBox(height: 10),
              _buildNumberField('Adults', _adultsController),
              const SizedBox(height: 10),
              _buildNumberField('Children (optional)', _childrenController),
              const SizedBox(height: 10),
              _buildTextField(_pickupController, 'Pickup Address'),
              const SizedBox(height: 10),
              _buildTextField(_dropoffController, 'Drop-off Address (optional)'),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedPackage,
                hint: const Text('Select Package', style: TextStyle(color: Colors.white)),
                dropdownColor: Colors.grey[900],
                items: _tourPackages.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (v) => setState(() => _selectedPackage = v),
                validator: (v) => v == null ? 'Please select a package' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sendWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Send Booking Request via WhatsApp',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your booking request will be sent directly to our admin',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType, bool readOnly = false, VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      validator: (v) => v == null || v.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(child: _buildTextField(controller, label, keyboardType: TextInputType.number)),
        const SizedBox(width: 10),
        Column(
          children: [
            IconButton(onPressed: () => _changeNumber(controller, 1), icon: const Icon(Icons.add, color: Colors.orange)),
            IconButton(onPressed: () => _changeNumber(controller, -1), icon: const Icon(Icons.remove, color: Colors.orange)),
          ],
        )
      ],
    );
  }

  void _changeNumber(TextEditingController controller, int delta) {
    int value = int.tryParse(controller.text) ?? 0;
    value += delta;
    if (value < 0) value = 0;
    controller.text = value.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> _sendWhatsApp() async {
    if (!_formKey.currentState!.validate()) return;

    // Prepare the message with your requested format
    String message = '''
Hey umar ! Hoping you are enjoying good health .We would like to get this package
-------------------

*🎯 Package Selected:* $_selectedPackage

*👤 Customer Details:*
• *Full Name:* ${_fullNameController.text}
• *Email:* ${_emailController.text}

*📅 Booking Details:*
• *Tour Date:* ${_dateController.text}
• *Adults:* ${_adultsController.text}
• *Children:* ${_childrenController.text}
• *Pickup Address:* ${_pickupController.text}
• *Drop-off Address:* ${_dropoffController.text}

*📱 Sent via Emirates Facilities App*
*⏰ Timestamp:* ${DateTime.now().toString().split('.').first}
''';

    final encodedMessage = Uri.encodeComponent(message);
    
    // Format WhatsApp number
    String formattedNumber = _adminWhatsAppNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Create WhatsApp URL
    final whatsappUrl = 'https://wa.me/$formattedNumber?text=$encodedMessage';
    
    // Alternative URL
    final alternativeUrl = 'https://api.whatsapp.com/send?phone=$formattedNumber&text=$encodedMessage';

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(Uri.parse(alternativeUrl))) {
        await launchUrl(Uri.parse(alternativeUrl), mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp. Please make sure WhatsApp is installed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _adultsController.dispose();
    _childrenController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }
}