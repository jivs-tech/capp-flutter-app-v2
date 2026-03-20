import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'title': 'COVID-19', 'date': 'Mar 18, 2026', 'confidence': 0.87},
      {'title': 'Flu', 'date': 'Mar 10, 2026', 'confidence': 0.79},
      {'title': 'Allergy', 'date': 'Feb 20, 2026', 'confidence': 0.74},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Health History')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.history, color: Color(0xFF2D6BFF)),
              title: Text(item['title'] as String),
              subtitle: Text(item['date'] as String),
              trailing: Text(
                '${((item['confidence'] as double) * 100).toStringAsFixed(0)}%',
              ),
            ),
          );
        },
      ),
    );
  }
}
