import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/gpt4mini_service.dart';
import '../providers/diary_provider.dart';
import '../models/photo.dart';

class PhotoUploadPage extends StatefulWidget {
  @override
  _PhotoUploadPageState createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  File? _image;
  String? _diaryTitle;
  String? _diaryText;
  bool _isLoading = false;
  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isLoading = true;
        _diaryTitle = null;
        _diaryText = null;
      });

      try {
        // 📌 1. GPT-4o-mini를 사용하여 일기 제목 & 내용 자동 생성
        final gptService = GPT4MiniService();
        final gptResult = await gptService.generateDiary(
            "사진 분석 결과 없음",  // 라벨 (추후 추가 가능)
            "위치 정보 없음",  // 위치 (추후 추가 가능)
            "감정 정보 없음"   // 감정 (추후 추가 가능)
        );

        String diaryTitle = gptResult['title'] ?? 'AI 생성 일기';
        String diaryStory = gptResult['story'] ?? 'AI가 작성한 자동 일기 내용';

        setState(() {
          _diaryTitle = diaryTitle;
          _diaryText = diaryStory;
          _isLoading = false;
        });

        // 📌 2. Provider를 사용하여 GalleryPage에 반영
        final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
        diaryProvider.addDiary(Photo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          url: _image!.path,
          title: diaryTitle,
          dateTimeOriginal: DateTime.now(),
          location: "위치 정보 없음",
          weather: '날씨 정보 없음',
          story: diaryStory,
        ));
      } catch (e) {
        setState(() {
          _diaryText = "❌ 분석 실패: $e";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사진 업로드 & 일기 생성')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('📸 이미지를 선택하세요', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                : Column(
              children: [
                Image.file(_image!, height: 200, fit: BoxFit.cover),
                SizedBox(height: 10),
                _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                  children: [
                    Text(
                      _diaryTitle ?? "제목 생성 중...",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _diaryText ?? "일기 생성 중...",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => getImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('카메라'),
                ),
                ElevatedButton.icon(
                  onPressed: () => getImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text('갤러리'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
