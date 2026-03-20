import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _messages = <Map<String, dynamic>>[
    {'text': 'Hello! Tell me your symptoms.', 'user': false},
  ];
  final _controller = TextEditingController();

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _controller.text.trim(), 'user': true});
      _messages.add({'text': 'Thanks, I\'m analyzing...', 'user': false});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Health Assistant')),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, i) {
              final m = _messages[i];
              return Align(
                alignment: m['user'] ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: m['user'] ? const Color(0xFF11A5FF) : const Color(0xFFF1F4FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(m['text'], style: TextStyle(color: m['user'] ? Colors.white : Colors.black87)),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Type symptom...', border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(12)), borderSide: BorderSide.none), filled: true, fillColor: Color(0xFFF4F7FB)))),
            const SizedBox(width: 8),
            CircleAvatar(backgroundColor: const Color(0xFF11A5FF), child: IconButton(onPressed: _send, icon: const Icon(Icons.send, color: Colors.white))),
          ]),
        )
      ]),
    );
  }
}
