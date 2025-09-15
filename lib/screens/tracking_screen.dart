// lib/screens/tracking_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _trackingController = TextEditingController();
  String _statusMessage = 'Enter your tracking number to check status.';
  bool _canDownloadPdf = false;
  Map<String, dynamic> _submissionData = {};

  final String _googleAppsScriptUrl =
      "https://script.google.com/macros/s/AKfycbyFsYskrpuIPe0YJaxCSfqLo4sJjGc7zWUUiPY-8OHc7kGQTrxCjkAGWYsFrv7Lkztiqw/exec";

  Future<void> _trackApplication() async {
    String trackingNumber = _trackingController.text.trim();
    if (trackingNumber.isEmpty) {
      setState(() {
        _statusMessage = 'Please enter a valid tracking number.';
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse('$_googleAppsScriptUrl?tracking_number=$trackingNumber'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Found') {
          _submissionData = data['submission'];
          setState(() {
            _statusMessage = 'Status: ${_submissionData['status']}';
            _canDownloadPdf = _submissionData['status'] == 'Completed';
          });
        } else {
          setState(() {
            _statusMessage = 'No application found with this tracking number.';
            _canDownloadPdf = false;
          });
        }
      } else {
        setState(() {
          _statusMessage = 'Failed to fetch status. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'An error occurred. Please check your internet connection.';
      });
    }
  }

  Future<void> _generatePdfAndDownload() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Receipt for Service', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('App Name: My App'),
                ..._submissionData.entries.map((e) => pw.Text('${e.key.replaceAll('_', ' ')}: ${e.value}')),
              ],
            ),
          );
        },
      ),
    );

    final String dir = (await getTemporaryDirectory()).path;
    final String filePath = '$dir/receipt_${_submissionData['tracking_number']}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(filePath);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF Downloaded!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Application')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _trackingController,
              decoration: const InputDecoration(
                labelText: 'Enter Tracking Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _trackApplication,
              child: const Text('Track'),
            ),
            const SizedBox(height: 20),
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (_canDownloadPdf)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: _generatePdfAndDownload,
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text('Download PDF', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}