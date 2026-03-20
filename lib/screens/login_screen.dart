import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool hide = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter email and password')));
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text('Welcome back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Sign in to continue', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email))),
                      const SizedBox(height: 12),
                      TextField(controller: password, obscureText: hide, decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock), suffixIcon: IconButton(icon: Icon(hide ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => hide = !hide)))),
                      const SizedBox(height: 20),
                      ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)), child: const Text('Sign In')),
                      const SizedBox(height: 12),
                      OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/signup'), style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)), child: const Text('Create Account')),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(child: TextButton(onPressed: () {}, child: const Text('Forgot password?'))),
            ],
          ),
        ),
      ),
    );
  }
}
