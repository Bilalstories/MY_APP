// lib/screens/service_form_screen.dart

import 'package:flutter/material.dart';
import '../models/category.dart';

class ServiceFormScreen extends StatefulWidget {
  final Service service;

  const ServiceFormScreen({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceFormScreenState createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // A map to store the user input for each field
  final Map<String, dynamic> _formData = {};
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (var field in widget.service.fields) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.name),
        backgroundColor: Colors.blue.shade800,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: widget.service.fields.length,
            itemBuilder: (ctx, index) {
              final field = widget.service.fields[index];
              final label = field['label'];
              final type = field['type'];
              final controller = _controllers[index];

              if (type == 'text') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _formData[label] = value;
                    },
                  ),
                );
              } else if (type == 'date') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        controller.text = "${date.day}/${date.month}/${date.year}";
                        _formData[label] = date.toIso8601String(); // Save as a parsable string
                      }
                    },
                    onSaved: (value) {
                      _formData[label] = value;
                    },
                  ),
                );
              }
              // Add more field types here (e.g., number, dropdown)
              return SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            print('Form Data Submitted: $_formData');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Application Submitted Successfully!')),
            );
          }
        },
        label: Text('Submit Application'),
        icon: Icon(Icons.send),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }
}