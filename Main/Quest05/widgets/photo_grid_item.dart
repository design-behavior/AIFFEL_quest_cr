import 'package:flutter/material.dart';
import 'dart:io';
import '../models/photo.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;

  PhotoGridItem({required this.photo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0), // ✅ 모서리 살짝 둥글게 처리
      child: Stack(
        children: [
          photo.url.startsWith('assets/') // ✅ 기존 assets 이미지인지 확인
              ? Image.asset(
            photo.url,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // ✅ 이미지가 꽉 차도록 설정
          )
              : Image.file(
            File(photo.url),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
