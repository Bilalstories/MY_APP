import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

class ServicesScreen extends StatelessWidget {
  final Category category;
  const ServicesScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.services.length,
        itemBuilder: (context, index) {
          final service = category.services[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.assignment_turned_in, color: Colors.deepPurple),
              title: Text(service.name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Fee: ₹${service.fee.toStringAsFixed(0)}'),
              trailing: ElevatedButton(
                child: Text('Apply'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String trackingId = '7276263372-' + DateTime.now().millisecondsSinceEpoch.toString();
                      String userDetails = 'Service: ${service.name}\nFee: ₹${service.fee.toStringAsFixed(0)}\nTracking ID: $trackingId';
                      return AlertDialog(
                        title: Text('Apply for ${service.name}'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Form Link:'),
                            SelectableText(service.formUrl, style: TextStyle(color: Colors.blue)),
                            SizedBox(height: 12),
                            Text('Tracking ID:'),
                            SelectableText(trackingId, style: TextStyle(color: Colors.deepPurple)),
                            SizedBox(height: 12),
                            Text('Payment Options:'),
                            SizedBox(height: 8),
                            ElevatedButton.icon(
                              icon: Icon(Icons.account_balance_wallet),
                              label: Text('Pay with Wallet'),
                              onPressed: () async {
                                // Wallet payment logic
                                final prefs = await SharedPreferences.getInstance();
                                String? pin = prefs.getString('wallet_pin');
                                double balance = prefs.getDouble('wallet_balance') ?? 0;
                                if (pin == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Set wallet PIN in Wallet screen first.')));
                                  return;
                                }
                                final pinController = TextEditingController();
                                bool verified = false;
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Enter Wallet PIN'),
                                    content: TextField(
                                      controller: pinController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      decoration: InputDecoration(hintText: 'Enter 4-digit PIN'),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Verify'),
                                        onPressed: () {
                                          if (pinController.text == pin) {
                                            verified = true;
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                                if (verified) {
                                  if (balance >= service.fee) {
                                    balance -= service.fee;
                                    List<String> history = prefs.getStringList('wallet_history') ?? [];
                                    history.add('Service Payment: ${service.name} ₹${service.fee} on ${DateTime.now()}');
                                    await prefs.setDouble('wallet_balance', balance);
                                    await prefs.setStringList('wallet_history', history);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment successful!')));
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Insufficient wallet balance.')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect PIN.')));
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            Text('UPI Payment:'),
                            SelectableText('UPI ID: 7276263372-3@ybl'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('WhatsApp Send'),
                            onPressed: () {
                              final url = 'https://wa.me/917276263372?text=' + Uri.encodeComponent(userDetails);
                              // Use url_launcher to open WhatsApp
                              // launch(url);
                            },
                          ),
                          TextButton(
                            child: Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
