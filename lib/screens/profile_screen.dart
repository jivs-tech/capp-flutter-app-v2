import 'package:flutter/material.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 44)),
        const SizedBox(height: 12),
        const Text('Jiya Vyas', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('jiya@yourmail.com', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        Card(child: SwitchListTile(value: _dark, onChanged: (v) { setState(() => _dark = v); MyApp.of(context).setDarkMode(v); }, title: const Text('Dark Mode'))),
        const SizedBox(height: 8),
        Card(child: ListTile(leading: const Icon(Icons.notifications), title: const Text('Notifications'), subtitle: const Text('Health reminders enabled'))),
        const SizedBox(height: 8),
        Card(child: ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false))),
      ]),
    );
  }
}
