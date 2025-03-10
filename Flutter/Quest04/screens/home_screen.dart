import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';
import 'my_reservation_pc_screen.dart';
import 'my_reservation_conference_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공유오피스 일상'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.pushNamed(context, '/moreMenu');
            },
          ),
        ],
      ),
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'PC 예약'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: '회의실 예약'),
        ],
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 1:
        return MyReservationPCScreen();
      case 2:
        return MyReservationConferenceScreen();
      default:
        return HomeContentScreen();
    }
  }
}

/// ✅ 홈 화면 컨텐츠 (PC 예약 & 회의실 예약 구분)
class HomeContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMyPCReservation(context, provider),
          _buildMyConferenceReservation(context, provider),
        ],
      ),
    );
  }

  Widget _buildMyPCReservation(BuildContext context, ReservationProvider provider) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('나의 PC 예약 현황', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          provider.pcReservations.isEmpty
              ? Text('현재 예약한 PC가 없습니다.')
              : Column(
            children: provider.pcReservations.map((reservation) {
              return ListTile(
                title: Text('${reservation['location']} - ${reservation['pcNumber']}'),
                subtitle: Text('날짜: ${reservation['date']} | 시간: ${reservation['time']}'),
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/reservation_pc');
            },
            child: Text('PC 예약하기'),
          ),
        ],
      ),
    );
  }

  Widget _buildMyConferenceReservation(BuildContext context, ReservationProvider provider) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('나의 회의실 예약 현황', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          provider.conferenceReservations.isEmpty
              ? Text('현재 예약한 회의실이 없습니다.')
              : Column(
            children: provider.conferenceReservations.map((reservation) {
              return ListTile(
                title: Text('${reservation['location']} - ${reservation['roomNumber']}'),
                subtitle: Text('날짜: ${reservation['date']} | 시간: ${reservation['time']}'),
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/reservation_conference');
            },
            child: Text('회의실 예약하기'),
          ),
        ],
      ),
    );
  }
}