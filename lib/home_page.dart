import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'demo_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          tooltip: 'Log out',
          icon: const Icon(Icons.logout),
          onPressed: () {
            DemoAuth.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          },
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Icon(Icons.home, size: 80, color: Colors.indigo),
        const SizedBox(height: 16),
        Text(
          'Welcome, Student!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        const Text(
          'Use the navigation bar below to explore the app.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        const Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Calculator'),
                subtitle: Text('Perform basic arithmetic operations.'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                subtitle: Text('View your student information.'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Social Media'),
                subtitle: Text(
                  'Share posts, like and comment on the student feed.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Jolex Pasignasigna\nCCE106(3450)',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
