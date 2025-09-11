import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/categories.dart';
import '../models/category.dart';
import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.95,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServicesScreen(category: category),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (category.iconUrl.isEmpty)
                    const Icon(Icons.category, size: 48)
                  else if (category.iconUrl.startsWith('http'))
                    Image.network(
                      category.iconUrl,
                      height: 48,
                      width: 48,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, size: 48),
                    )
                  else
                    Image.asset(
                      'assets/${category.iconUrl}',
                      height: 48,
                      width: 48,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, size: 48),
                    ),
                  SizedBox(height: 12),
                  Text(category.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(service.name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Fee: ₹${service.fee.toStringAsFixed(0)}'),
              trailing: ElevatedButton(
                child: Text('Apply'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceFormScreen(service: service),
                    ),
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

class ServiceFormScreen extends StatefulWidget {
  final Service service;
  const ServiceFormScreen({Key? key, required this.service}) : super(key: key);

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _imagePath;
  String? _trackingId;
  final Map<String, TextEditingController> _fieldCtrls = {};

  Future<int> _nextSeq() async {
    final prefs = await SharedPreferences.getInstance();
    int seq = prefs.getInt('submission_seq') ?? 0;
    seq += 1;
    await prefs.setInt('submission_seq', seq);
    return seq;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final seq = await _nextSeq();
    final id = '7276263372-$seq';
    setState(() => _trackingId = id);
    final prefs = await SharedPreferences.getInstance();
    final submissions = prefs.getStringList('submissions') ?? [];
    // collect dynamic fields
    final Map<String, String> values = {};
    for (var f in widget.service.fields) {
      final k = f['key'] as String;
      values[k] = _fieldCtrls[k]?.text ?? '';
    }
    submissions.add('${id}|${widget.service.name}|${values.toString()}|${_imagePath ?? ''}');
    await prefs.setStringList('submissions', submissions);
    // Show success
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Submitted'),
        content: Text('Tracking ID: $id'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
    if (file != null) setState(() => _imagePath = file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Service: ${widget.service.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Fee: ₹${widget.service.fee.toStringAsFixed(0)}'),
              const SizedBox(height: 16),
              // dynamic fields
              ...widget.service.fields.map((f) {
                final key = f['key'] as String;
                _fieldCtrls.putIfAbsent(key, () => TextEditingController());
                final label = f['label'] as String? ?? key;
                final type = f['type'] as String? ?? 'text';
                if (type == 'multiline') {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(controller: _fieldCtrls[key], maxLines: 3, decoration: InputDecoration(labelText: label), validator: (v) => v==null||v.isEmpty? 'Enter $label':null),
                  );
                } else if (type == 'number') {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(controller: _fieldCtrls[key], keyboardType: TextInputType.number, decoration: InputDecoration(labelText: label), validator: (v) => v==null||v.isEmpty? 'Enter $label':null),
                  );
                } else if (type == 'select') {
                  final options = (f['options'] as List?)?.map((e) => e.toString()).toList() ?? [];
                  // simple dropdown
                  String? sel;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: DropdownButtonFormField<String>(
                      items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                      onChanged: (v) => _fieldCtrls[key]!.text = v ?? '',
                      decoration: InputDecoration(labelText: label),
                      validator: (v) => v==null||v.isEmpty? 'Select $label':null,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(controller: _fieldCtrls[key], decoration: InputDecoration(labelText: label), validator: (v) => v==null||v.isEmpty? 'Enter $label':null),
                );
              }).toList(),
              Row(
                children: [
                  ElevatedButton.icon(icon: const Icon(Icons.photo), label: const Text('Upload Image'), onPressed: _pickImage),
                  const SizedBox(width: 12),
                  if (_imagePath != null) const Text('Image selected')
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Submit')),
              const SizedBox(height: 12),
              if (_trackingId != null) SelectableText('Tracking ID: $_trackingId', style: const TextStyle(color: Colors.deepPurple)),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text('Payment', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.qr_code),
                label: const Text('Pay Now / Show QR'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Pay ₹'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/upi_qr.png', height: 180, errorBuilder: (_,__ ,___) => const Icon(Icons.qr_code, size: 120)),
                          const SizedBox(height: 8),
                          const SelectableText('UPI ID: 7276263372@ybl'),
                        ],
                      ),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
