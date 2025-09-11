import 'package:flutter/material.dart';
import '../data/categories.dart';
import 'categories_screen.dart' show ServiceFormScreen;
import 'package:my_app/data/categories.dart';
import 'service_form_screen.dart';

class SchemesScreen extends StatelessWidget {
  const SchemesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schemeCat = categories.firstWhere((c) => c.name.toLowerCase() == 'scheme', orElse: () => categories[0]);
    return Scaffold(
      appBar: AppBar(title: const Text('Government Schemes & Services')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: schemeCat.services.length,
        itemBuilder: (ctx, i) {
          final s = schemeCat.services[i];
          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text('Fee ₹${s.fee.toStringAsFixed(0)}'),
              trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ServiceFormScreen(service: s))), child: const Text('Apply')),
            ),
          );
        },
      ),
    );
  }
}
