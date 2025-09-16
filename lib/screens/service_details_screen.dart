import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key, required this.service});

  final Service service;

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _documentController = TextEditingController();
  File? _pickedFile;

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
        _documentController.text = pickedFile.name;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would handle the form submission, e.g., send data to a server
      // For now, let's just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted for: ${widget.service.name}'),
        ),
      );
      // You can also access the user's data here:
      // print('Name: ${_nameController.text}');
      // print('Phone: ${_phoneController.text}');
      // if (_pickedFile != null) {
      //   print('File Path: ${_pickedFile!.path}');
      // }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // User Information
              Text(
                'Enter Your Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Document Upload Section
              Text(
                'Upload Documents',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _documentController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Document/Image',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.upload_file),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.folder_open),
                    onPressed: _pickFile,
                  ),
                ),
                validator: (value) {
                  if (_pickedFile == null) {
                    return 'Please upload a document';
                  }
                  return null;
                },
              ),
              if (_pickedFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.file(
                    _pickedFile!,
                    height: 150,
                  ),
                ),
              const SizedBox(height: 24),
              // Submit Button
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.send),
                label: const Text('Submit Application'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}