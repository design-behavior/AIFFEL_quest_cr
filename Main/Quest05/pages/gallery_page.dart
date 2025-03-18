import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/photo.dart';
import '../pages/diary_detail_page.dart';
import '../widgets/photo_grid_item.dart';
import '../providers/diary_provider.dart';
import '../services/gpt4mini_service.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final photos = diaryProvider.diaries;

    return Scaffold(
      appBar: AppBar(title: Text('AI 사진일기')),
      body: photos.isEmpty
          ? Center(child: Text('📸 사진을 업로드하고 AI 일기를 작성하세요!', style: TextStyle(fontSize: 8)))
          : GridView.builder(
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryDetailPage(photo: photos[index]),
                ),
              );
            },
            child: PhotoGridItem(photo: photos[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showUploadOptions(context, diaryProvider);
        },
      ),
    );
  }

  // 모달 바텀 시트 표시
  void _showUploadOptions(BuildContext context, DiaryProvider diaryProvider) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('일기 쓰기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blue),
                title: Text('카메라 촬영'),
                onTap: () => _pickImage(context, ImageSource.camera, diaryProvider),
              ),
              ListTile(
                leading: Icon(Icons.photo, color: Colors.green),
                title: Text('갤러리에서 선택'),
                onTap: () => _pickImage(context, ImageSource.gallery, diaryProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  // 이미지 선택 후 GPT-4o-mini를 이용하여 일기 생성 후 `DiaryProvider`에 추가
  Future<void> _pickImage(BuildContext context, ImageSource source, DiaryProvider diaryProvider) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      Navigator.pop(context); // ✅ 모달 닫기

      try {
        // ✅ GPT-4o-mini를 사용하여 일기 제목 & 내용 자동 생성
        final gptService = GPT4MiniService();
        final gptResult = await gptService.generateDiary(
            "사진 분석 결과 없음",
            "위치 정보 없음",
            "감정 정보 없음"
        );

        String diaryTitle = gptResult['title'] ?? 'AI 생성 일기';
        String diaryStory = gptResult['story'] ?? 'AI가 작성한 자동 일기 내용';

        // ✅ 새로운 일기 추가
        diaryProvider.addDiary(Photo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          url: file.path,
          title: diaryTitle,
          dateTimeOriginal: DateTime.now(),
          location: "위치 정보 없음",
          weather: '날씨 정보 없음',
          story: diaryStory,
        ));
      } catch (e) {
        print("❌ GPT-4o-mini 분석 실패: $e");
      }
    }
  }
}
