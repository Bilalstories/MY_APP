// lib/screens/services_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/models/form_model.dart';
import 'package:upi_india/upi_india.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int _currentStep = 0;
  Service? _selectedService;
  final _formKey = GlobalKey<FormState>();
  final _textControllers = <String, TextEditingController>{};
  final _picker = ImagePicker();
  XFile? _paymentProof;
  bool _isLoading = false;

  final String _googleAppsScriptUrl =
      "https://script.google.com/macros/s/AKfycbyFsYskrpuIPe0YJaxCSfqLo4sJjGc7zWUUiPY-8OHc7kGQTrxCjkAGWYsFrv7Lkztiqw/exec";
  
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? _upiApps;

  @override
  void initState() {
    super.initState();
    _upiIndia.getAllUpiApps().then((apps) {
      setState(() {
        _upiApps = apps;
      });
    });
    for (var service in widget.category.services) {
      for (var field in service.form.fields) {
        if (!_textControllers.containsKey(field.name)) {
          _textControllers[field.name] = TextEditingController();
        }
      }
    }
  }

  @override
  void dispose() {
    _textControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _pickPaymentScreenshot() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _paymentProof = image;
    });
  }

  Future<void> _submitApplication() async {
    if (_paymentProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload the payment screenshot.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final trackingId = 'TRACK-${DateTime.now().millisecondsSinceEpoch}';

    final Map<String, dynamic> submissionData = {
      "tracking_id": trackingId,
      "service_name": _selectedService!.name,
      "price": _selectedService!.price,
      "category": widget.category.name,
      "payment_status": "Paid",
      "submission_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };

    _selectedService!.form.fields.forEach((field) {
      submissionData[field.name.toLowerCase().replaceAll(' ', '_')] = _textControllers[field.name]?.text ?? '';
    });
    
    String jsonData = json.encode(submissionData);

    try {
      final response = await http.post(
        Uri.parse(_googleAppsScriptUrl),
        body: jsonData,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await _generateReceiptPdf(submissionData, trackingId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Application submitted successfully! Tracking ID: $trackingId'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit application. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Check your internet connection.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _generateReceiptPdf(Map<String, dynamic> data, String trackingId) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Service Application Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Tracking ID: $trackingId', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
              pw.SizedBox(height: 20),
              pw.Text('Submission Details:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...data.entries.map((e) {
                return pw.Text('${e.key.replaceAll('_', ' ')}: ${e.value.toString()}');
              }).toList(),
            ],
          );
        },
      ),
    );

    final String dir = (await getTemporaryDirectory()).path;
    final String filePath = '$dir/receipt_$trackingId.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    
    await OpenFilex.open(filePath);
  }

  Future<void> _startUpiPayment(UpiApp app) async {
    try {
      final UpiResponse response = await _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "7276263372@okbizaxis",
        receiverName: "Golden Multi Services",
        transactionRefId: 'TID-${DateTime.now().millisecondsSinceEpoch}',
        transactionNote: _selectedService!.name,
        amount: _selectedService!.price.toDouble(),
      );

      // Handle the response if needed.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initiate UPI payment: ${e.toString()}')),
      );
    }
  }

  Widget _buildFormField(FormFieldModel field) {
    if (field.inputType == 'textarea') {
      return TextFormField(
        controller: _textControllers[field.name],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        maxLines: 4,
        validator: (value) {
          if (value == null || value.isEmpty) return 'This field is required.';
          return null;
        },
      );
    } else if (field.inputType == 'phone') {
      return TextFormField(
        controller: _textControllers[field.name],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) return 'This field is required.';
          return null;
        },
      );
    } else if (field.inputType == 'email') {
      return TextFormField(
        controller: _textControllers[field.name],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) return 'This field is required.';
          return null;
        },
      );
    } else {
      return TextFormField(
        controller: _textControllers[field.name],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: field.inputType == 'number' ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) return 'This field is required.';
          return null;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedService == null)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.category.services.length,
                itemBuilder: (ctx, index) {
                  final service = widget.category.services[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(service.name),
                      trailing: Text('₹${service.price}'),
                      onTap: () {
                        setState(() {
                          _selectedService = service;
                          _currentStep = 0;
                        });
                      },
                    ),
                  );
                },
              ),
            if (_selectedService != null)
              Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep == 0) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _currentStep = 1;
                      });
                    }
                  } else if (_currentStep == 1) {
                    setState(() {
                      _currentStep = 2;
                    });
                  } else if (_currentStep == 2) {
                    _submitApplication();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep--;
                    });
                  } else {
                    setState(() {
                      _selectedService = null;
                      _currentStep = 0;
                    });
                  }
                },
                steps: [
                  Step(
                    title: const Text('Fill Details'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: _selectedService!.form.fields.map((field) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _buildFormField(field),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Step(
                    title: const Text('Make Payment'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Amount: ₹${_selectedService!.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/qr.jpg',
                                height: 250,
                                width: 250,
                              ),
                              const SizedBox(height: 10),
                              const Text('Scan & Pay'),
                              const SizedBox(height: 5),
                              const Text('UPI ID: 7276263372@okbizaxis', style: TextStyle(fontWeight: FontWeight.bold)),
                              const Text('Golden Multi Services', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('OR Pay with a UPI App:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        // Show the list of UPI apps to pay
                        if (_upiApps != null)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _upiApps!.map((app) {
                              return ElevatedButton.icon(
                                onPressed: () => _startUpiPayment(app),
                                icon: Image.memory(
                                  app.icon,
                                  height: 24,
                                ),
                                label: Text(app.name),
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 20),
                        const Text('After paying, upload a screenshot of the successful payment.', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: _pickPaymentScreenshot,
                          icon: const Icon(Icons.file_upload),
                          label: const Text('Upload Payment Screenshot'),
                        ),
                        if (_paymentProof != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.file(
                              File(_paymentProof!.path),
                              height: 150,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Review & Submit'),
                    content: _isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ..._selectedService!.form.fields.map((field) {
                                return Text('${field.label}: ${_textControllers[field.name]?.text ?? ''}');
                              }).toList(),
                              const SizedBox(height: 10),
                              Text('Service: ${_selectedService!.name}'),
                              Text('Price: ₹${_selectedService!.price}'),
                              const SizedBox(height: 10),
                              const Text('Please review all details before final submission.'),
                              ElevatedButton(
                                onPressed: _submitApplication,
                                child: const Text('Final Submit'),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}