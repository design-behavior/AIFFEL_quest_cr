import 'package:flutter/material.dart';

class ReservationProvider with ChangeNotifier {
  List<Map<String, String>> pcReservations = [];
  List<Map<String, String>> conferenceReservations = []; // ✅ 추가됨

  void addPCReservation(String location, String pcNumber, String date, String time) {
    pcReservations.add({
      'location': location,
      'pcNumber': pcNumber,
      'date': date,
      'time': time,
    });
    notifyListeners();
  }

  void addConferenceReservation(String location, String roomNumber, String date, String time) {
    conferenceReservations.add({
      'location': location,
      'roomNumber': roomNumber,
      'date': date,
      'time': time,
    });
    notifyListeners();
  }

  void clearReservations() {
    pcReservations.clear();
    conferenceReservations.clear();
    notifyListeners();
  }
}
