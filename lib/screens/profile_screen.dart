// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:my_app/screens/tracking_screen.dart';
import 'package:my_app/screens/privacy_policy_screen.dart';
import 'package:my_app/models/application.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final List<Application> userApplications = const [
    Application(trackingNumber: '7276263372-1', serviceName: 'Aadhar Card Update', status: 'Pending'),
    Application(trackingNumber: '7276263372-2', serviceName: 'New Passport', status: 'Completed'),
    Application(trackingNumber: '7276263372-3', serviceName: 'Income Certificate', status: 'In Progress'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'User Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'My Applications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userApplications.length,
              itemBuilder: (context, index) {
                final app = userApplications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(app.serviceName),
                    subtitle: Text('Tracking No: ${app.trackingNumber}\nStatus: ${app.status}'),
                    isThreeLine: true,
                    trailing: app.status == 'Completed'
                        ? ElevatedButton.icon(
                            onPressed: () {
                              // We need to implement the PDF download logic here
                            },
                            icon: const Icon(Icons.download, color: Colors.white),
                            label: const Text('Download PDF', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          )
                        : null,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.policy),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const PrivacyPolicyScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                // Log out functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const Center(child: Text("Privacy Policy Page Content")),
    );
  }
}