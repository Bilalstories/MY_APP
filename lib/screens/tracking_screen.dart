import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _ctrl = TextEditingController();
  List<String> _submissions = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _submissions = prefs.getStringList('submissions') ?? []);
  }

  void _search() {
    final q = _ctrl.text.trim();
    if (q.isEmpty) return;
    final results = _submissions.where((s) => s.startsWith(q)).toList();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Results (${results.length})'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: results.map((r) => ListTile(title: Text(r))).toList(),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Submission')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _ctrl, decoration: const InputDecoration(labelText: 'Enter Tracking ID')), 
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _search, child: const Text('Search')),
            const SizedBox(height: 20),
            const Text('Recent submissions:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(child: ListView.builder(itemCount: _submissions.length, itemBuilder: (ctx,i) => ListTile(title: Text(_submissions[i])))),
          ],
        ),
      ),
    );
  }
}
