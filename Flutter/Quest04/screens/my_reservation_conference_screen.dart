import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class MyReservationConferenceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('나의 회의실 예약 현황',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          provider.conferenceReservations.isEmpty
              ? Center(child: Text('현재 예약한 회의실이 없습니다.'))
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.conferenceReservations.length,
            itemBuilder: (context, index) {
              final reservation = provider.conferenceReservations[index];
              return ListTile(
                title: Text('${reservation['location']} - ${reservation['roomNumber']}'),
                subtitle: Text('날짜: ${reservation['date']} | 시간: ${reservation['time']}'),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reservation_conference');
              },
              child: Text('회의실 예약하기'),
            ),
          ),
        ],
      ),
    );
  }
}
