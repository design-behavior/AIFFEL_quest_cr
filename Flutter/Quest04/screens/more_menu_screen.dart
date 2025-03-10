import 'package:flutter/material.dart';

class MoreMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('더 보기'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('앱 설정'),
            onTap: () {
              // TODO: 설정 화면 연결
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('도움말'),
            onTap: () {
              // TODO: 도움말 화면 연결
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('로그아웃'),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 로그아웃 확인 다이얼로그
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // 홈 화면으로 이동
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('로그아웃 되었습니다.')),
                );
              },
              child: Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }
}
