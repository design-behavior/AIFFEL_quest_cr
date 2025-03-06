import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isCat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0), // 아이콘 왼쪽 여백 추가
          child: FaIcon(FontAwesomeIcons.cat), // 고양이 아이콘
        ),
        title: Text('고영희'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
        children: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                bool result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(isCat: false),
                  ),
                );
                setState(() {
                  isCat = result;
                });
              },
              child: Text('강댕댕이 볼까?'),
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                print('isCat: true');
              },
              child: Image.asset(
                'assets/cat.jpeg',
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final bool isCat;

  SecondPage({required this.isCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0), // 아이콘 왼쪽 여백 추가
          child: FaIcon(FontAwesomeIcons.dog), // 강아지 아이콘
        ),
        title: Text('강댕댕'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
        children: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('고영희 볼래?'),
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                print('isCat: false');
              },
              child: Image.asset(
                'assets/dog.jpeg',
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
