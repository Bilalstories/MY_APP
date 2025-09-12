// lib/widgets/digital_profile_form.dart

import 'package:flutter/material.dart';
import 'package:my_app/widgets/general_profile_form.dart';

class DigitalProfileForm extends StatelessWidget {
  final VoidCallback onUpdate;
  const DigitalProfileForm({Key? key, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Digital Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GeneralProfileForm(onUpdate: onUpdate), // Reusing the General Form fields
        TextFormField(
          decoration: const InputDecoration(labelText: 'PAN Number'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'EPFO Number'),
        ),
      ],
    );
  }
}