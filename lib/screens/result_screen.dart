import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> diagnosis;
  final double confidence;
  const ResultScreen({super.key, required this.diagnosis, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final disease = data?['disease'] ?? 'Common Cold';
    final conf = data?['confidence'] ?? 0.82;
    final symptoms = data?['symptoms'] ?? ['Fever', 'Cough'];

    return Scaffold(
      appBar: AppBar(title: const Text('Diagnosis Report')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Card(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Result', style: TextStyle(color: Colors.grey)), const SizedBox(height: 8), Text(disease, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Confidence: ${(conf * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Color(0xFF2D6BFF))), Wrap(spacing: 6, children: (symptoms as List).map((s) => Chip(label: Text(s.toString()))).toList())]))),
          const SizedBox(height: 12),
          Card(elevation: 1, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: const Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Recommendations', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('• Rest well and drink fluids'), Text('• Monitor your temperature'), Text('• Consult a doctor if symptoms worsen')])))
        ]),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(12), child: ElevatedButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false), style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)), child: const Text('Back to Dashboard'))),
    );
  }
}
