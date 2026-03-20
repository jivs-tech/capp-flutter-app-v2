import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dark = false;
  bool _push = true;
  bool _tips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0D9F83), Color(0xFF22A8FF)])),
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
          child: Row(children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
            const SizedBox(width: 4),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Settings', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('Customize app', style: TextStyle(color: Colors.white70))])
          ]),
        ),
        Expanded(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), child: SwitchListTile(title: const Text('Dark Mode'), subtitle: const Text('Enable dark theme'), value: _dark, onChanged: (v) => setState(() => _dark = v))),
            const SizedBox(height: 8),
            const Text('Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF354563))),
            const SizedBox(height: 8),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), child: Column(children: [
              SwitchListTile(title: const Text('Push Notifications'), subtitle: const Text('Get health reminders'), value: _push, onChanged: (v) => setState(() => _push = v)),
              const Divider(height: 0),
              SwitchListTile(title: const Text('Health Tips'), subtitle: const Text('Daily wellness tips'), value: _tips, onChanged: (v) => setState(() => _tips = v)),
            ])),
            const SizedBox(height: 8),
            const Text('Language & Region', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF354563))),
            const SizedBox(height: 8),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), child: ListTile(leading: const Icon(Icons.language), title: const Text('Language'), subtitle: const Text('English'), trailing: const Icon(Icons.arrow_forward_ios, size: 16))),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEB4C5B), minimumSize: const Size.fromHeight(50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Logout'))
          ]),
        ),
      ]),
    );
  }
}
