import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import './providers/diary_provider.dart';
import './pages/gallery_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // ✅ .env 파일 강제 로드
    print("📌 OpenAI API Key: ${dotenv.env['OPENAI_API_KEY']}"); // ✅ 콘솔에서 API 키 확인
  } catch (e) {
    print("❌ .env 파일을 찾을 수 없음: $e");
  }

  await initializeDateFormatting('ko_KR', null); // ✅ 한국어 날짜 포맷팅 초기화

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiaryProvider()),
      ],
      child: DiaryApp(),
    ),
  );
}

class DiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GalleryPage(),
    );
  }
}
