import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  void _showAccount(BuildContext context, String account) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Selected account: $account')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Social Media')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Connect With Me',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Sample accounts for this activity.\nTap an account to display its username.',
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.facebook, color: Colors.blue),
            title: const Text('Facebook'),
            subtitle: const Text('student.sample'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAccount(context, 'Facebook: student.sample'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.pink),
            title: const Text('Instagram'),
            subtitle: const Text('@student.sample'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAccount(context, 'Instagram: @student.sample'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.play_circle, color: Colors.red),
            title: const Text('YouTube'),
            subtitle: const Text('@StudentChannel'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAccount(context, 'YouTube: @StudentChannel'),
          ),
        ),
      ],
    ),
  );
}
