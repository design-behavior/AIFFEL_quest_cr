import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/my_reservation_pc_screen.dart';
import 'screens/my_reservation_conference_screen.dart';
import 'screens/reservation_pc_screen.dart';
import 'screens/reservation_conference_screen.dart';
import 'screens/more_menu_screen.dart';
import 'providers/reservation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
      ],
      child: SharedOfficeApp(),
    ),
  );
}

class SharedOfficeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '공유오피스 예약 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/myReservation_pc': (context) => MyReservationPCScreen(),
        '/myReservation_conference': (context) => MyReservationConferenceScreen(),
        '/reservation_pc': (context) => ReservationPCScreen(),
        '/reservation_conference': (context) => ReservationConferenceScreen(),
        '/moreMenu': (context) => MoreMenuScreen(),
      },
    );
  }
}
