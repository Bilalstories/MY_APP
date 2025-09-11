import 'package:flutter/material.dart';

class HomeScreenBaseline extends StatelessWidget {
  const HomeScreenBaseline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Baseline')),
      body: const Center(child: Text('App baseline - working state')),
    );
  }
}
