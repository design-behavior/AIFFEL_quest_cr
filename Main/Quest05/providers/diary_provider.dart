import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/gpt4mini_service.dart';

class DiaryProvider with ChangeNotifier {
  List<Photo> _diaries = [ // ✅ 기존 더미 데이터 유지
    Photo(
      id: '1',
      url: 'assets/images/1.jpg',
      title: '찐만두',
      dateTimeOriginal: DateTime.now(),
      location: '부산 해운대',
      weather: '맑음',
      story: '여름날 해운대 만두집에 그냥 들렀는데, 의외의 맛에 깜짝 놀랐네.',
    ),
    Photo(
      id: '2',
      url: 'assets/images/2.jpg',
      title: '겨울 산',
      dateTimeOriginal: DateTime.now(),
      location: '강원도 설악산',
      weather: '눈',
      story: '겨울철 눈 덮인 산의 아름다운 풍경.',
    ),
    Photo(
      id: '3',
      url: 'assets/images/3.jpg',
      title: '가을 단풍',
      dateTimeOriginal: DateTime.now(),
      location: '일본 오사카',
      weather: '맑음',
      story: '가을에 찍은 오사카의 골목길, 단풍이 이쁘다.',
    ),
    Photo(
      id: '4',
      url: 'assets/images/4.jpg',
      title: '강가 옆 도심',
      dateTimeOriginal: DateTime.now(),
      location: '영국 런던',
      weather: '화창함',
      story: '아마도 영국 여행 사진인 듯. 해질녁 런던 템즈강.',
    ),
  ];

  List<Photo> get diaries => _diaries; // ✅ 리스트 가져오기

  // ✅ GPT-4o-mini를 사용하여 일기 자동 생성 후 추가
  Future<void> addDiaryWithAI(String imagePath) async {
    try {
      final gptService = GPT4MiniService();
      final gptResult = await gptService.generateDiary(
          "사진 분석 결과 없음",
          "위치 정보 없음",
          "감정 정보 없음"
      );

      String diaryTitle = gptResult['title'] ?? 'AI 생성 일기';
      String diaryStory = gptResult['story'] ?? 'AI가 작성한 자동 일기 내용';

      final newDiary = Photo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        url: imagePath,
        title: diaryTitle,
        dateTimeOriginal: DateTime.now(),
        location: "위치 정보 없음",
        weather: '날씨 정보 없음',
        story: diaryStory,
      );

      _diaries = [..._diaries, newDiary]; // 기존 데이터 유지하면서 새로운 데이터 추가
      notifyListeners();
    } catch (e) {
      print("❌ AI 일기 생성 실패: $e");
    }
  }

  // ✅ 기존 방식으로 일기 직접 추가 (AI 생성 없이)
  void addDiary(Photo diary) {
    _diaries = [..._diaries, diary];
    notifyListeners();
  }

  // ✅ 특정 ID의 일기 삭제
  void removeDiary(String id) {
    _diaries = _diaries.where((diary) => diary.id != id).toList();
    notifyListeners();
  }
}
