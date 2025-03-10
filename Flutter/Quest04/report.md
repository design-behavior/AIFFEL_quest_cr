# 디지털 공유 오피스 웹서비스 구조 분석 후 약간의 기능수정하기

## 웹서비스 정보
- **웹서비스 이름**
  - 디지털 공유 오피스 예약 서비스
- **타켓**
  - 업무용 PC가 지역사회 시민 혹은 지역사회 방문객

## 웹서비스 구조도 (AS-IS)
![image](https://github.com/user-attachments/assets/8cc8d5d4-2439-42af-ae90-24a4f4110165)

## 웹서비스 와이어프레임 (사용툴 : Google Slides)
![image](https://github.com/user-attachments/assets/5a395075-4f43-4025-8ecb-3813322da67f)

## 프로토타이핑 (사용툴 : marvelapp.com)
https://marvelapp.com/prototype/33hf92dg/screen/96799538

## 웹서비스 구조 (TO-BE)
![image](https://github.com/user-attachments/assets/dea03fd6-a389-4f57-a1b9-f902adbe986d)
- 실제로 예약 서비스를 이용하면서 불편했던 점
  - 나의 예약내역을 제일 먼저 확인하고 싶음 > 로그인 사용자의 Home에 예약내역이 노출되게 변경
  - 예약하기 전 현재 예약내역을 먼저 확인하는 편인데, 나의 예약과 예약하기가 분리되어 있어서 불편 > 나의 예약현황 내에 '예약하기' 버튼으로 통합

- 그.러.나. 야무진 꿈과는 다르게 flutter 로 구현하는데에는 한계가 있어, PC 예약하면 나의 PC 예약과 Home 화면에 PC 예약내역이 노출되는 정도까지 시도하였음

## 페이지 구현
1. main.dart - 메인 화면으로 기본적인 구성으로 작성
2. home_screen.dart - Home 화면의 구성으로 작성
3. my_reservation_conference_screen.dart - 나의 PC 예약 목록 화면의 구성으로 작성
4. reservation_pc_screen.dart - PC 예약 화면의 구성으로 작성

## 구현영상 
https://github.com/design-behavior/AIFFEL_quest_cr/blob/7a95ef0ba12be755b6c828bed266dd706924443f/Flutter/Quest04/Screen_recording_sunQuest04.webm


## 회고
- 그래픽디자인 요소가 배제된 와이어프레임 정도만으로 화면을 구성하는데에도 어려움이 많고 막막하여, 와이어프레임의 레이아웃을 구현해 내지는 못하였고 기본 기능만 배치하는 것에 집중하였음.
- AS-IS 구조와는 다르게, Home 화면에 예약현황을 반영하는 구조로 flutter 구현을 시도하였는데, 개발팀이 왜 그렇게 home 화면이나 목록에 실시간 정보 표시하는 것을 싫어했는지 조금은 이해가 되었음.
- 안드로이드 스튜디오로 진행하면서 SDK 오류, gradle 오류가 너무 많이 발생하여, 코딩보다는 터미널에서 flutter doctor, flutter clean, flutter run, flutter pub get 사용한 시간이 더 긴 것 같음. dart보다 터미널과 더 친해진 인공지능 서비스 디자인하기 subQuest!!!
