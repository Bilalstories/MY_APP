// lib/screens/service_form_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/category.dart';
import 'package:path/path.dart' as path;
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ServiceFormScreen extends StatefulWidget {
  final Service service;

  const ServiceFormScreen({Key? key, required this.service}) : super(key: key);

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  File? _pickedImage;
  int _trackingNumber = 1000;

  @override
  void initState() {
    super.initState();
    for (var field in widget.service.fields) {
      _controllers[field['key']] = TextEditingController();
    }
    if (!_controllers.containsKey('full_name')) {
      _controllers['full_name'] = TextEditingController();
    }
    if (!_controllers.containsKey('mobile_number')) {
      _controllers['mobile_number'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      _trackingNumber++;
      String trackingNumber = "7276263372-$_trackingNumber";
      String currentTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      Map<String, String> formData = {};
      _controllers.forEach((key, controller) {
        formData[key] = controller.text;
      });
      formData['service_name'] = widget.service.name;
      formData['price'] = widget.service.price.toString();
      formData['tracking_number'] = trackingNumber;
      formData['submission_time'] = currentTime;
      formData['status'] = 'Pending';

      String scriptUrl = "YOUR_GOOGLE_APPS_SCRIPT_URL_HERE"; 
      try {
        await http.post(Uri.parse(scriptUrl), body: formData);
      } catch (e) {
        print("Error sending data to Google Sheets: $e");
      }

      String whatsappMessage = """
*New Service Request*
Service: ${widget.service.name}
Price: ₹${widget.service.price.toStringAsFixed(0)}
Tracking No: $trackingNumber
Status: Pending
Time: $currentTime
Customer Details:
Name: ${formData['full_name'] ?? 'N/A'}
Mobile: ${formData['mobile_number'] ?? 'N/A'}
""";
      final Uri whatsappUri = Uri.parse("whatsapp://send?phone=7276263372&text=${Uri.encodeComponent(whatsappMessage)}");
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp not installed.')),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application Submitted. You will be contacted shortly for further process.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.service.fields.isEmpty)
                const Text(
                  'Please fill out the following details:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ...widget.service.fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    controller: _controllers[field['key']],
                    decoration: InputDecoration(
                      labelText: field['label'],
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ${field['label']}';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Upload Document (Image)'),
              ),
              if (_pickedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(_pickedImage!),
                ),
              const SizedBox(height: 20),
              Text(
                'Price: ₹${widget.service.price.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'After submitting, we will contact you for the payment and further process.',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Submit Application", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}