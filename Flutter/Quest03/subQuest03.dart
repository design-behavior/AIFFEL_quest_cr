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

//

<윤순천 회고>
: appbar 좌측에 고양이, 강아지 아이콘을 구분해서 넣으려고 하니, 내장 icon은 pets만 지원하여, font_awesome_flutter 외부 패키지를 활용하여 구분하였음.
- import 'package:font_awesome_flutter/font_awesome_flutter.dart';

: font_awesome_flutter의 버전이 맞지 않아 아이콘이 표시 되지 않았는데, pub.dev에서 font_awesome_flutter를 검색하여 버전을 맞춰주니, 아이콘이 정상적으로 표시되었음.
  - dependencies:
      font_awesome_flutter: ^10.6.0 > font_awesome_flutter: ^10.8.0

: Image.asset 등록 시 이미지를 등록할 때마다 pubspec.yaml 에서 pub get 해야 하는 것을 몰랐는데, 이번에 확실히 알게 되었음. (참.. 귀찮은 일인 듯)

: 버튼과 고양이/강아지 사진을 가로 기준 중앙정렬을 하기 위하 CrossAxisAlignment 를 설정하였는데, Align 으로 감싸지 않아서 오류가 생겼음.
  요소의 배치를 조정하거나 꾸미기 위해 html 처럼 열고 닫고 그 안에 감싸는 것이 너무 복잡하게 느껴짐
//
