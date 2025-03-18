import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // ✅ dotenv 추가

class GPT4MiniService {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? ''; // ✅ .env에서 API 키 불러오기

  Future<Map<String, String>> generateDiary(String labels, String location, String emotion) async {
    if (apiKey.isEmpty) {
      throw Exception("❌ OpenAI API 키가 설정되지 않았습니다.");
    }

    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "system", "content": "당신은 감성적인 일기를 작성하는 AI입니다. 제목과 내용을 각각 반환하세요."},
          {"role": "user", "content": "이 사진을 기반으로 하루 일기를 작성해줘.\n"
              "📸 사진 속 장면: $labels\n"
              "📍 위치: $location\n"
              "😀 감정: $emotion"}
        ],
        "max_tokens": 200
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes)); // ✅ UTF-8 변환하여 파싱
      print("📌 GPT-4o-mini 응답 데이터: $responseData"); // ✅ 콘솔에서 응답 확인

      String generatedText = responseData["choices"][0]["message"]["content"];

      List<String> lines = generatedText.split("\n");
      print("📌 응답 분할 데이터: $lines"); // ✅ 응답이 어떻게 분리되는지 확인

      String title = lines.isNotEmpty ? lines[0].trim() : "AI 생성 일기";
      String story = lines.length > 1 ? lines.sublist(1).join("\n").trim() : "AI가 작성한 자동 일기 내용";

      print("📌 생성된 제목: $title"); // ✅ 제목 디버깅
      print("📌 생성된 내용: $story");

      return {"title": title, "story": story};
    } else {
      throw Exception("GPT-4o-mini API 호출 실패: ${response.statusCode}");
    }
  }
}
