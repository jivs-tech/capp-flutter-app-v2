import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0D9F83), Color(0xFF22A8FF)])),
        child: SafeArea(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.health_and_safety, size: 84, color: Colors.white),
              const SizedBox(height: 16),
              const Text('Smart Health AI', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Your personal health companion', style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0D9F83), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 14)), child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold))),
            ]),
          ),
        ),
      ),
    );
  }
}
