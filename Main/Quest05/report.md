# 사진을 업로드하면, 사진 분석 후 일기를 작성해 주는 AI 사진일기

## 웹서비스 정보
- **웹서비스 이름**
  - AI 사진일기
    
- **타켓**
  - 사진 찍는 것을 좋아하지만, 감성적인 글을 쓰는 것에는 재능이 없는 MZ 세대

## 앱 구조도
![image](https://github.com/user-attachments/assets/71db690c-b84b-47af-8e2c-619661f3dcad)


## 앱 와이어프레임 (사용툴 : 구현 화면 캡쳐)
![WIREFRAME](https://github.com/user-attachments/assets/a25ba1a9-2efa-423f-ab4a-d9d6a621c313)


## 프로토타이핑 (사용툴 : marvelapp.com)
[https://marvelapp.com/prototype/33hf92dg/screen/96799538](https://marvelapp.com/prototype/33hf92dg/screen/96868438)


## 페이지 구현
1. main.dart
- 앱의 진입점이며, MultiProvider를 사용하여 DiaryProvider를 전역 상태로 관리
- .env 파일을 로드하여 OpenAI API 키를 설정
- GalleryPage()를 홈 화면으로 지정

2. pages/gallery_page.dart
- 사진 목록을 그리드 형태로 표시하는 갤러리 페이지
- FloatingActionButton을 통해 새 사진을 업로드하는 기능 제공
- PhotoGridItem을 클릭하면 DiaryDetailPage로 이동

3. pages/diary_detail_page.dart
- 일기 상세 페이지로, 선택한 사진 및 일기 내용을 표시
- 삭제 버튼을 통해 일기를 삭제할 수 있으며, 삭제 확인 팝업 제공
   
4. pages/photo_upload_page.dart
- 사진을 업로드하고, GPT-4o-mini를 사용하여 제목과 내용을 자동 생성
- ImagePicker를 활용하여 카메라 촬영 또는 갤러리에서 사진 선택 가능
- 생성된 일기를 DiaryProvider에 저장

5. models/photo.dart
- 사진 및 일기 데이터를 저장하는 Photo 모델 클래스
- id, url, title, dateTimeOriginal, location, weather, story 필드 포함
- JSON 변환을 위한 toJson() 및 fromJson() 메서드 제공

7. providers/diary_provider.dart
- 앱 전역에서 일기 데이터를 관리하는 ChangeNotifier Provider
- 일기 추가 및 삭제 기능 제공 (addDiary(), removeDiary())
- GalleryPage 및 DiaryDetailPage에서 Provider를 통해 데이터 접근
    
8. services/gpt4mini_service.dart
- GPT-4o-mini API를 사용하여 사진을 기반으로 일기 제목 및 내용 자동 생성
- .env 파일에서 OpenAI API 키를 불러와 API 요청 수행
- API 응답에서 제목과 내용을 분리하여 반환
    
9. widgets/photo_grid_item.dart
- 갤러리에서 개별 사진을 그리드 형태로 표시하는 위젯
- ClipRRect를 사용해 이미지의 모서리를 둥글게 처리
- GestureDetector를 사용해 클릭 시 DiaryDetailPage로 이동


## 회고
- dart로 앱을 구성하는 것을 예상보다 일찍 마무리 되었는데, 외부 서비스와 연동하는 단계에서 2일 이상 걸렸음.
- 첫번째 시도 : google cloud vision(사진 분석), Gemini(택스트 작성)로 로컬 가상서버 생성하여 시도. 사진을 분석하지 못함
- 두번째 시도 : YOLOv8(사진 분석), GPT-2(텍스트 작성)로 로컬 가상서버 생성하여 시도. 사진을 분석하지 못함, 여러 테스트 결과, 가상서버에 접근하고 실행은 하고 있으나 사진 분석과 텍스트 생성을 못함
- 세번재 시도 : 로컬이 아닌 웹에서 시도해 보고자 우선, Firebase 부터 설정 시작하였으나 Gradle 문제가 해결되지 않아 포기.
- 네번째 시도 : GPT4o-mini를 가상이 아닌 로컬 서버에 설치하여 시도하였음. 텍스트 생성 후 글자가 깨지는 문제가 있었는데 FONT 패키지를 사용하여 생성된 텍스트가 깨끗하게 표시하였음.

- 이번 프로젝트를 통해, 프로젝트 파일을 4개 정도 만들었는데, 안드로이드 스튜디오의 프로젝트 개념을 이해하게 된 것 같음.
- 가상 서버와 프로젝트 디렉터리 관리에 대해 이해가 조금 생긴 것 같음.
- 각 파일 간의 상호작용에 대한 이해가 조금 더 생긴 것 같음.
