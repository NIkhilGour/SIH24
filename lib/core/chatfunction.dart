import 'package:http/http.dart' as http;
import 'dart:convert';

const String geminiApiKey = 'AIzaSyD27Qyj208bYwn2Rx3kb92aoMg4-O8NaEo';
const String geminiURL =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey';

Future<String> getGeminiResponse(String userInput) async {
  final prompt = '''
You are a helpful herbal expert AI chatbot for a virtual herbal garden app.
Only answer questions related to medicinal plants and you can greet if user is greeting to you . If the query is unrelated, say "I'm designed to help only with medicinal plants."

User query: $userInput
''';

  final response = await http.post(
    Uri.parse(geminiURL),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final text = data['candidates'][0]['content']['parts'][0]['text'];
    return text;
  } else {
    print("Gemini error: ${response.body}");
    return "Sorry, I couldn't fetch the response right now.";
  }
}
