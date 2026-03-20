import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool hide = true;
  bool agree = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  void signUp() {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty || confirm.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields')));
      return;
    }
    if (password.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords don\'t match')));
      return;
    }
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Accept terms to continue')));
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(controller: name, decoration: const InputDecoration(labelText: 'Full Name')),
                  const SizedBox(height: 10),
                  TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 10),
                  TextField(controller: password, obscureText: hide, decoration: InputDecoration(labelText: 'Password', suffixIcon: IconButton(icon: Icon(hide ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => hide = !hide)))),
                  const SizedBox(height: 10),
                  TextField(controller: confirm, obscureText: hide, decoration: const InputDecoration(labelText: 'Confirm Password')),
                  const SizedBox(height: 10),
                  Row(children: [Checkbox(value: agree, onChanged: (v) => setState(() => agree = v ?? false)), const Expanded(child: Text('I agree to terms and conditions'))]),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: signUp, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)), child: const Text('Sign Up')),
                  const SizedBox(height: 8),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Sign In')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
