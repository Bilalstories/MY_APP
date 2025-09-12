// lib/widgets/general_profile_form.dart

import 'package:flutter/material.dart';
import 'package:my_app/data/states_districts.dart';

class GeneralProfileForm extends StatefulWidget {
  final VoidCallback onUpdate;
  const GeneralProfileForm({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _GeneralProfileFormState createState() => _GeneralProfileFormState();
}

class _GeneralProfileFormState extends State<GeneralProfileForm> {
  String? _selectedState;
  String? _selectedDistrict;
  List<String> _districts = [];

  void _onStateChanged(String? state) {
    setState(() {
      _selectedState = state;
      _selectedDistrict = null; // Reset district when state changes
      if (state != null && statesAndDistricts.containsKey(state)) {
        _districts = statesAndDistricts[state]!;
      } else {
        _districts = [];
      }
      widget.onUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('General Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Gender'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Date of Birth'),
        ),
        DropdownButtonFormField<String>(
          value: _selectedState,
          decoration: const InputDecoration(labelText: 'State'),
          items: statesAndDistricts.keys.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state),
            );
          }).toList(),
          onChanged: _onStateChanged,
        ),
        DropdownButtonFormField<String>(
          value: _selectedDistrict,
          decoration: const InputDecoration(labelText: 'District'),
          items: _districts.map((String district) {
            return DropdownMenuItem<String>(
              value: district,
              child: Text(district),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedDistrict = value;
              widget.onUpdate();
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Email Address'),
        ),
      ],
    );
  }
}