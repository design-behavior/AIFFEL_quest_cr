import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Image.asset(
                'assets/coffee.jpeg', // 같은 폴더 내의 이미지
                width: 30,  // 이미지 크기 조정
                height: 30,
              ),
              SizedBox(width: 10), // 이미지와 텍스트 사이 간격
              Expanded(
                child: Text(
                  '플러터 앱 만들기',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          centerTitle: true, // ✅ AppBar의 title을 중앙 정렬
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Column 중앙 정렬
          children: [
            Container(
              height: 100, // 크기 지정
              color: Colors.black,
              child: Center( // ElevatedButton을 가운데 정렬
                child: ElevatedButton(
                  onPressed: () {
                    print('버튼이 눌렸습니다.');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 색상 변경
                  ),
                  child: Text('버튼을 눌러보세요.'),
                ),
              ),
            ),
            SizedBox(height: 20), // 간격 추가
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300, // 전체 영역 크기
                height: 300,
                color: Colors.white, // 배경색 추가
                child: Stack(
                  alignment: Alignment.topLeft, // 좌측 상단 정렬
                  children: [
                    Positioned(left: 0, top: 0, child: Container(width: 300, height: 300, color: Colors.red)),
                    Positioned(left: 0, top: 0, child: Container(width: 240, height: 240, color: Colors.green)),
                    Positioned(left: 0, top: 0, child: Container(width: 180, height: 180, color: Colors.blue)),
                    Positioned(left: 0, top: 0, child: Container(width: 120, height: 120, color: Colors.yellow)),
                    Positioned(left: 0, top: 0, child: Container(width: 60, height: 60, color: Colors.pink)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



[회고]

아이콘을 정할 때, 이미지를 애셋으로 저장하여 불러오는 방법을 선택하였음.
assets 폴더 위치를 잘못 지정하여 이미지를 인식하지 못했었는데, 최상위 레벨에 assets 폴더 생성 후에 이미지를 아이콘으로 정상적으로 불러 왔음.

박스 중첩할 때, 박스 전체 가운데 정렬과 박스 개별 시작점을 지정하는데, 헷갈려서 어려움이 있었는데,
박스 전체 정렬은 center, 개별 시작점은 positioned로 지정하여 고정하니, 해결되었음.

'플러터 앱 만들기' 타이틀 중앙정렬을 Expanded 없이 했을 때 오류가 났었는데, Expanded 지정 후 해결되었음.
*/
