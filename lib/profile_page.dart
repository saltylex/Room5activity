import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Profile')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Jolex Pasignasigna',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        const Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.badge),
                title: Text('Student ID'),
                subtitle: Text('557989'),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Course and Year'),
                subtitle: Text('BSIT — 3rd Year'),
              ),
              ListTile(
                leading: Icon(Icons.class_),
                title: Text('Subject and Section'),
                subtitle: Text('CCE106(3450)'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text('Jolex129@gmail.com'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
