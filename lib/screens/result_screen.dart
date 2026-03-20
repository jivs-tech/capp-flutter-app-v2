import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> diagnosis;
  final double confidence;
  const ResultScreen({super.key, required this.diagnosis, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final disease = result?['disease'] ?? 'Typhoid Fever';
    final conf = result?['confidence'] ?? 0.86;
    final symptoms = result?['symptoms'] ?? ['Fever', 'Cough', 'Fatigue'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0, title: const Text('Analysis Complete', style: TextStyle(color: Color(0xFF1F2B45)))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(colors: [Color(0xFF0D9F83), Color(0xFF22A8FF)])),
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Analysis Complete', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text('Here\'s what we found', style: TextStyle(color: Colors.white70))]),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12)]),
            child: ListTile(
              leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFF1BBC9C), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.health_and_safety, color: Colors.white, size: 20)),
              title: const Text('Predicted Condition', style: TextStyle(color: Color(0xFF7C8CAA), fontSize: 12)),
              subtitle: Text(disease, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Precautions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...[
            'Get plenty of rest',
            'Stay hydrated - drink boiled water',
            'Maintain hand hygiene',
            'Eat digestible foods',
            'Isolate to prevent spread',
          ].map((text) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]), child: Row(children: [Container(width: 26, height: 26, decoration: BoxDecoration(color: const Color(0xFF1BBC9C), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.check, color: Colors.white, size: 16)), const SizedBox(width: 10), Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF303B52))))]))).toList(),
          const SizedBox(height: 22),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [Color(0xFF1BBC9C), Color(0xFF11A5FF)])), child: ElevatedButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false), style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size.fromHeight(52)), child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)))),
        ]),
      ),
    );
  }
}
