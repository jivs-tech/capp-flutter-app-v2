class MockAPI {
  static const Map<String, List<String>> _diseaseSymptoms = {
    'Common Cold': ['Cough', 'Sore Throat', 'Congestion', 'Headache'],
    'Flu': ['Fever', 'Cough', 'Body Aches', 'Fatigue', 'Headache'],
    'Allergies': ['Congestion', 'Cough', 'Sore Throat'],
    'COVID-19': ['Fever', 'Cough', 'Shortness of Breath', 'Fatigue'],
    'Bronchitis': ['Cough', 'Shortness of Breath', 'Fatigue', 'Chest Discomfort'],
    'Gastroenteritis': ['Nausea', 'Diarrhea', 'Headache', 'Fatigue'],
  };

  static Map<String, dynamic> predictDisease(List<String> symptoms) {
    String bestMatch = 'Unknown';
    double highestScore = 0.0;

    _diseaseSymptoms.forEach((disease, diseaseSymptoms) {
      int matchCount = symptoms.where((s) => diseaseSymptoms.contains(s)).length;
      double score = matchCount / diseaseSymptoms.length;

      if (score > highestScore) {
        highestScore = score;
        bestMatch = disease;
      }
    });

    if (highestScore == 0) {
      bestMatch = 'Inconclusive';
      highestScore = 0.3;
    }

    return {
      'disease': bestMatch,
      'confidence': highestScore.clamp(0.5, 0.95),
      'symptoms': symptoms,
    };
  }
}
