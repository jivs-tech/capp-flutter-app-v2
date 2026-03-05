import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Message> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final Set<String> _collectedSymptoms = {};
  bool _diagnosisComplete = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage(
        'Hello! I\'m your AI Health Assistant. 🏥\n\nLet\'s start by understanding how you\'re feeling. What symptoms are you experiencing today?');
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleUserInput(String input) {
    if (input.trim().isEmpty) return;

    _addUserMessage(input);
    _inputController.clear();

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      // Parse symptom from user input
      List<String> allSymptoms = [
        'Fever',
        'Cough',
        'Shortness of Breath',
        'Headache',
        'Sore Throat',
        'Fatigue',
        'Nausea',
        'Diarrhea',
        'Body Aches',
        'Congestion',
      ];

      String inputLower = input.toLowerCase();
      for (String symptom in allSymptoms) {
        if (inputLower.contains(symptom.toLowerCase())) {
          _collectedSymptoms.add(symptom);
        }
      }

      String response = '';

      if (_collectedSymptoms.isEmpty) {
        response =
            'I didn\'t catch any specific symptoms. Could you tell me more? For example:\n• Fever\n• Cough\n• Sore Throat\n• Body Aches\n• Headache';
      } else if (_collectedSymptoms.length == 1) {
        response =
            'I see you have ${_collectedSymptoms.first}. 🤔\n\nDo you have any other symptoms? Or should I analyze your condition based on this?';
      } else if (_collectedSymptoms.length <= 3) {
        response =
            'Got it! You have:\n• ${_collectedSymptoms.join('\n• ')}\n\nAny other symptoms? Or should I provide a diagnosis?';
      } else {
        response =
            'I\'ve noted all your symptoms. Let me analyze your condition now...';
        setState(() {
          _diagnosisComplete = true;
        });

        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;

          final result =
              MockAPI.predictDisease(List<String>.from(_collectedSymptoms));

          setState(() {
            _isLoading = false;
          });

          _addBotMessage(
            '📋 **DIAGNOSIS REPORT**\n\n'
            'Primary Diagnosis: **${result['disease']}**\n'
            'Confidence Level: **${(result['confidence'] * 100).toStringAsFixed(0)}%**\n\n'
            '⚠️ **AI Prediction Disclaimer**: This is an AI-based assessment only. Please consult a qualified healthcare professional for a definitive diagnosis.\n\n'
            'Would you like to view recommended tests and treatment suggestions?',
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          });
        });

        return;
      }

      setState(() {
        _isLoading = false;
      });

      _addBotMessage(response);
    });
  }

  void _getFullDiagnosis() {
    if (_collectedSymptoms.isEmpty) {
      _addBotMessage('Please tell me your symptoms first!');
      return;
    }

    final result =
        MockAPI.predictDisease(List<String>.from(_collectedSymptoms));

    Navigator.of(context).pushNamed(
      '/result',
      arguments: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Assistant'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? const Color(0xFF00BCD4)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF00BCD4).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Analyzing symptoms...'),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: 'Tell me your symptoms...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: _handleUserInput,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF00BCD4),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      _handleUserInput(_inputController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_collectedSymptoms.isNotEmpty && !_diagnosisComplete)
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _getFullDiagnosis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Get Full Diagnosis',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
