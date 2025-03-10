import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class MyReservationPCScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('나의 PC 예약 현황',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          provider.pcReservations.isEmpty
              ? Center(child: Text('현재 예약한 PC가 없습니다.'))
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.pcReservations.length,
            itemBuilder: (context, index) {
              final reservation = provider.pcReservations[index];
              return ListTile(
                title: Text('${reservation['location']} - ${reservation['pcNumber']}'),
                subtitle: Text('날짜: ${reservation['date']} | 시간: ${reservation['time']}'),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reservation_pc');
              },
              child: Text('PC 예약하기'),
            ),
          ),
        ],
      ),
    );
  }
}
