import 'package:flutter/material.dart';
import '../data/categories.dart';
import 'service_form_screen.dart';

class SchemesScreen extends StatelessWidget {
  const SchemesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schemeCat = categories.firstWhere(
/*************  ✨ Windsurf Command ⭐  *************/
  /// Returns a [Scaffold] widget that displays a list of available schemes and services in
  /// a [ListView]. Each item in the list is a [Card] widget that contains a [ListTile]
  /// with the name of the scheme/service, the fee, and an [ElevatedButton] that navigates to
  /// the [ServiceFormScreen] when pressed.
/*******  1d76d897-d502-44aa-9331-c75936cbd8b4  *******/      (c) => c.name.toLowerCase().contains('scheme'),
      orElse: () => categories[0],
    );
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