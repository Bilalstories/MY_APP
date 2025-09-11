import 'package:flutter/material.dart';
import '../data/categories.dart';
import 'service_form_screen.dart';

class BanksScreen extends StatelessWidget {
  const BanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bankCat = categories.firstWhere(
      (c) => c.name.toLowerCase().contains('bank'),
      orElse: () => categories[0],
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Bank Services')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bankCat.services.length,
        itemBuilder: (ctx, i) {
          final s = bankCat.services[i];
          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text('Fee ₹${s.price.toStringAsFixed(0)}'), // s.fee -> s.price
              trailing: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => ServiceFormScreen(service: s)),
                ),
                child: const Text('Apply'),
              ),
            ),
          );
        },
      ),
    );
  }
}