import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';

import '../../helper/global.dart';

class APIs {
  //get answer from google gemini ai
  static Future<String> getAnswer(String question) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final content = [Content.text(question)];
      final res = await model.generateContent(content, safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
      ]);

      return res.text!;
    } catch (e) {
      log('getAnswerGeminiE: ${e.toString()}');
      return 'Ocorreu um erro, tente novamente';
    }
  }

  //get answer from chat gpt
  static Future<String> getAnswerGPT(String question) async {
    try {
      log('api key: $apiKey');

      //
      final res =
          await post(Uri.parse('https://api.openai.com/v1/chat/completions'),

              //headers
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $apiKeyGpT'
              },

              //body
              body: jsonEncode({
                "model": "gpt-3.5-turbo",
                "max_tokens": 2000,
                "temperature": 0,
                "messages": [
                  {"role": "user", "content": question},
                ]
              }));

      final data = jsonDecode(res.body);

      log('res: $data');
      return data['choices'][0]['message']['content'];
    } catch (e) {
      log('getAnswerGptE: $e');
      return 'Ocorreu um erro, tente novamente';
    }
  }
}
