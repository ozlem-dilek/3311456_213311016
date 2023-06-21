import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:studyapp2/models/motivation_model.dart';

class MotivationService {
  final String url =
      'https://api.api-ninjas.com/v1/quotes?category=success';

  Future<Motivation?> fetchMotivation() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'X-Api-Key': 'UsaRwqCQxXjvhtK5g97iNA==84aPAbMbvGDvBJ1v'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      if (jsonData.isNotEmpty) {
        final jsonMotivation = jsonData[0] as Map<String, dynamic>;
        final data = Motivation.fromJson(jsonMotivation);
        return data;
      }
    }

    print("İstek başarısız oldu: Hata: ${response.statusCode}");
    return null;
  }
}
