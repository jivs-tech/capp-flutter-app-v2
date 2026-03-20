import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide = true;
  bool _agree = false;

  void _submit() {
    if (_name.text.isEmpty || _email.text.isEmpty || _pass.text.isEmpty || _confirm.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please complete all fields')));
      return;
    }
    if (_pass.text != _confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agree to terms')));
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0, title: const Text('Create Account', style: TextStyle(color: Color(0xFF1D2C48)))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Join us today', style: TextStyle(fontSize: 16, color: Color(0xFF4D5E73))),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                TextFormField(controller: _name, decoration: const InputDecoration(hintText: 'Enter your name', prefixIcon: Icon(Icons.person_outline), filled: true, fillColor: Color(0xFFF5F7FF), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 10),
                TextFormField(controller: _email, decoration: const InputDecoration(hintText: 'Enter your email', prefixIcon: Icon(Icons.email_outlined), filled: true, fillColor: Color(0xFFF5F7FF), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 10),
                TextFormField(controller: _pass, obscureText: _hide, decoration: InputDecoration(hintText: 'Create password', prefixIcon: const Icon(Icons.lock_outline), filled: true, fillColor: const Color(0xFFF5F7FF), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none), suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _hide = !_hide)))),
                const SizedBox(height: 10),
                TextFormField(controller: _confirm, obscureText: _hide, decoration: const InputDecoration(hintText: 'Confirm password', prefixIcon: Icon(Icons.lock_outline), filled: true, fillColor: Color(0xFFF5F7FF), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 10),
                Row(children: [Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false)), const Expanded(child: Text('By signing up, you agree to our Terms', style: TextStyle(fontSize: 12, color: Color(0xFF6B768B))))]),
                const SizedBox(height: 8),
                Container(decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1BBC9C), Color(0xFF11A5FF)]), borderRadius: BorderRadius.circular(12)), height: 50, child: ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent), child: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)))),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
