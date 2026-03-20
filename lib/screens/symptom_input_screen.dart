import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class SymptomInputScreen extends StatefulWidget {
  const SymptomInputScreen({super.key});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  final _allSymptoms = [
    'Fever',
    'Cough',
    'Headache',
    'Fatigue',
    'Sore Throat',
    'Nausea',
    'Diarrhea',
    'Body Aches',
    'Congestion',
  ];
  final _selected = <String>{};
  bool _loading = false;

  void _submit() {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one symptom')),
      );
      return;
    }
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final result = MockAPI.predictDisease(_selected.toList());
      Navigator.pushNamed(context, '/result', arguments: result);
      setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your symptoms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allSymptoms.map((symptom) {
                final selected = _selected.contains(symptom);
                return FilterChip(
                  label: Text(symptom),
                  selected: selected,
                  selectedColor: const Color(0xFF2D6BFF),
                  onSelected: (v) => setState(
                    () =>
                        v ? _selected.add(symptom) : _selected.remove(symptom),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chosen:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              _selected.isEmpty
                  ? 'No symptoms selected yet'
                  : _selected.join(', '),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Analyze Symptoms'),
            ),
          ],
        ),
      ),
    );
  }
}
