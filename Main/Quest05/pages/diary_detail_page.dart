import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../models/photo.dart';
import '../providers/diary_provider.dart';

class DiaryDetailPage extends StatelessWidget {
  final Photo photo;

  DiaryDetailPage({required this.photo});

  // 날짜 변환 함수
  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy년 M월 d일 EEEE a h시 m분', 'ko_KR').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () => _confirmDelete(context), // ✅ 삭제 버튼 클릭 시 팝업 표시
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ 이미지 표시
              photo.url.startsWith('assets/')
                  ? Image.asset(
                photo.url,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(photo.url),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 10),

              // ✅ 날짜 및 위치 정보
              Text(
                formatDateTime(photo.dateTimeOriginal.toLocal()),
                style: TextStyle(fontSize: 10, fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              // ✅ 제목에서 "제목", ":", 공백 제거 후 표시
              Text(
                photo.title.replaceAll(RegExp(r'제목[:\s]*'), '').trim(),
                style: TextStyle(fontSize: 12, fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              // ✅ 일기 내용
              Text(
                photo.story,
                style: TextStyle(fontSize: 10, fontFamily: 'NotoSansKR'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ 삭제 확인 팝업
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("일기 삭제"),
          content: Text("일기를 삭제할까요?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // 취소 버튼
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                _deleteDiary(context);
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text("삭제", style: TextStyle(color: Colors.red)), // 삭제 버튼
            ),
          ],
        );
      },
    );
  }

  // ✅ 일기 삭제 기능
  void _deleteDiary(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
    diaryProvider.removeDiary(photo.id); // 해당 일기 삭제
    Navigator.pop(context); // 목록 화면으로 이동
  }
}
