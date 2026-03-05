import 'package:flutter/material.dart';

class TestRecommendation {
  final String name;
  final String severity;
  final Color severityColor;

  TestRecommendation({
    required this.name,
    required this.severity,
    required this.severityColor,
  });
}

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> diagnosis;
  final double confidence;

  const ResultScreen({
    super.key,
    required this.diagnosis,
    required this.confidence,
  });

  List<TestRecommendation> _getRecommendedTests(String disease) {
    Map<String, List<TestRecommendation>> testsByDisease = {
      'Common Cold': [
        TestRecommendation(
          name: 'Throat Culture',
          severity: 'Medium',
          severityColor: const Color(0xFFFFC107),
        ),
        TestRecommendation(
          name: 'CBC (Complete Blood Count)',
          severity: 'Medium',
          severityColor: const Color(0xFFFFC107),
        ),
      ],
      'Flu': [
        TestRecommendation(
          name: 'Blood Culture',
          severity: 'High',
          severityColor: const Color(0xFFE53935),
        ),
        TestRecommendation(
          name: 'Widal Test',
          severity: 'Medium',
          severityColor: const Color(0xFFFFC107),
        ),
        TestRecommendation(
          name: 'CBC',
          severity: 'High',
          severityColor: const Color(0xFFE53935),
        ),
      ],
      'COVID-19': [
        TestRecommendation(
          name: 'RT-PCR Test',
          severity: 'High',
          severityColor: const Color(0xFFE53935),
        ),
        TestRecommendation(
          name: 'Chest X-Ray',
          severity: 'High',
          severityColor: const Color(0xFFE53935),
        ),
        TestRecommendation(
          name: 'Blood Oxygen Test',
          severity: 'High',
          severityColor: const Color(0xFFE53935),
        ),
      ],
      'Allergies': [
        TestRecommendation(
          name: 'Allergy Panel',
          severity: 'Low',
          severityColor: const Color(0xFF66BB6A),
        ),
        TestRecommendation(
          name: 'Skin Prick Test',
          severity: 'Medium',
          severityColor: const Color(0xFFFFC107),
        ),
      ],
    };

    return testsByDisease[disease] ?? [
      TestRecommendation(
        name: 'General Health Panel',
        severity: 'Medium',
        severityColor: const Color(0xFFFFC107),
      ),
    ];
  }

  List<String> _getRecommendations(String disease) {
    Map<String, List<String>> recommendationsByDisease = {
      'Common Cold': [
        '✓ Rest for 7-10 days',
        '✓ Stay hydrated with warm fluids',
        '✓ Use throat lozenges',
        '✓ Gargle with salt water',
        '⚠️ Isolate to prevent spread',
      ],
      'Flu': [
        '✓ Complete bed rest (3-7 days)',
        '✓ Take prescribed antiviral medications',
        '✓ Maintain fever control',
        '✓ High protein diet',
        '⚠️ Isolate to prevent spread',
      ],
      'COVID-19': [
        '✓ Immediate medical consultation required',
        '✓ Home isolation (10-14 days minimum)',
        '✓ Monitor oxygen levels',
        '✓ Contact healthcare provider if symptoms worsen',
        '⚠️ Vaccinate when eligible',
      ],
      'Allergies': [
        '✓ Identify and avoid allergens',
        '✓ Take antihistamines as needed',
        '✓ Use nasal saline rinse',
        '✓ Stay in air-conditioned environment',
        '⚠️ Consider allergy testing',
      ],
    };

    return recommendationsByDisease[disease] ?? [
      '✓ Consult a healthcare professional',
      '⚠️ Monitor your symptoms closely',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final diagnosisData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final disease = diagnosisData?['disease'] ?? 'Unknown';
    final conf = diagnosisData?['confidence'] ?? 0.0;
    final symptoms = diagnosisData?['symptoms'] ?? [];

    List<TestRecommendation> tests = _getRecommendedTests(disease);
    List<String> recommendations = _getRecommendations(disease);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Report'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Diagnosis Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF00BCD4),
                    Color(0xFF00ACC1),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DIAGNOSIS REPORT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    disease,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Confidence: ${(conf * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Symptoms Summary
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Symptoms Reported',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (symptoms as List).map((symptom) => Chip(
                              label: Text(symptom.toString()),
                              backgroundColor: const Color(0xFF00BCD4)
                                  .withValues(alpha: 0.2),
                              labelStyle: const TextStyle(
                                color: Color(0xFF00BCD4),
                              ),
                            )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Isolation Measures
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: const Color(0xFF00BCD4).withValues(alpha: 0.1),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF00BCD4),
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Isolate to prevent spread',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Maintain distance from others to prevent transmission',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recommended Tests
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tests',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...tests.map((test) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(
                            Icons.science,
                            color: Color(0xFF00BCD4),
                          ),
                          title: Text(test.name),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: test.severityColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              test.severity,
                              style: TextStyle(
                                color: test.severityColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),

            // Recommendations
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...recommendations.map((rec) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          rec,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      )),
                ],
              ),
            ),

            // Disclaimer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  border: Border.all(color: Colors.orange[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning, color: Colors.orange[700], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'AI prediction: Consult a doctor for diagnosis.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Report saved to your history'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BCD4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save Report',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
