import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _controller = TextEditingController();
  final _messages = <Message>[Message(text: 'Hi! Tell me your symptoms to get advice.', isUser: false)];
  bool _loading = false;

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _controller.clear();
      _loading = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      final response = text.toLowerCase().contains('fever') ? 'I see you mentioned fever. Do you also have cough?' : 'Thanks. Please add more symptoms to improve diagnosis.';
      setState(() {
        _messages.add(Message(text: response, isUser: false));
        _loading = false;
      });
    });
  }

  void _diagnose() {
    final result = MockAPI.predictDisease(['Fever', 'Cough']);
    Navigator.pushNamed(context, '/result', arguments: result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chat')),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: msg.isUser ? const Color(0xFF2D6BFF) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(msg.text, style: TextStyle(color: msg.isUser ? Colors.white : Colors.black)),
                ),
              );
            },
          ),
        ),
        if (_loading) const LinearProgressIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(children: [
            Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Describe symptoms...', border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))))),),
            const SizedBox(width: 8),
            IconButton(onPressed: _send, icon: const Icon(Icons.send, color: Color(0xFF2D6BFF))),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(onPressed: _diagnose, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)), child: const Text('Get Diagnosis')),
        ),
      ]),
    );
  }
}
