import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationConferenceScreen extends StatefulWidget {
  @override
  _ReservationConferenceScreenState createState() =>
      _ReservationConferenceScreenState();
}

class _ReservationConferenceScreenState extends State<ReservationConferenceScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocation;
  String? _selectedRoomNumber;

  final List<String> locations = ['나노융합진흥원', '도시재생시범마을', '달숲청년거리'];
  final Map<String, List<String>> roomNumbers = {
    '나노융합진흥원': ['회의실-1', '회의실-2', '회의실-3'],
    '도시재생시범마을': ['회의실-1'],
    '달숲청년거리': ['회의실-1', '회의실-2'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회의실 예약하기'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(),
            _buildTimeSelector(),
            _buildLocationDropdown(),
            _buildRoomDropdown(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedDate != null &&
                  _selectedTime != null &&
                  _selectedLocation != null &&
                  _selectedRoomNumber != null
                  ? () => _reserveConferenceRoom(context) // ✅ 예약 추가
                  : null,
              child: Text('예약하기'),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 날짜 선택 위젯
  Widget _buildDateSelector() {
    return ListTile(
      title: Text(_selectedDate == null
          ? '예약 날짜 선택'
          : '예약 날짜: ${_selectedDate!.toLocal()}'.split(' ')[0]),
      trailing: Icon(Icons.calendar_today),
      onTap: _pickDate,
    );
  }

  /// 🔹 시간 선택 위젯
  Widget _buildTimeSelector() {
    return ListTile(
      title: Text(_selectedTime == null
          ? '예약 시간 선택'
          : '예약 시간: ${_selectedTime!.format(context)}'),
      trailing: Icon(Icons.access_time),
      onTap: _pickTime,
    );
  }

  /// 🔹 지점 선택 드롭다운
  Widget _buildLocationDropdown() {
    return DropdownButtonFormField<String>(
      hint: Text('지점 선택'),
      value: _selectedLocation,
      items: locations.map((location) {
        return DropdownMenuItem(value: location, child: Text(location));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedLocation = value;
          _selectedRoomNumber = null;
        });
      },
    );
  }

  /// 🔹 회의실 번호 선택 드롭다운
  Widget _buildRoomDropdown() {
    return DropdownButtonFormField<String>(
      hint: Text('회의실 번호 선택'),
      value: _selectedRoomNumber,
      items: (_selectedLocation != null ? roomNumbers[_selectedLocation]! : [])
          .map<DropdownMenuItem<String>>((room) {
        return DropdownMenuItem<String>(value: room, child: Text(room));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRoomNumber = value;
        });
      },
    );
  }

  /// 🔹 날짜 선택 다이얼로그
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// 🔹 시간 선택 다이얼로그
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  /// 🔹 예약하기 버튼 클릭 시 실행
  void _reserveConferenceRoom(BuildContext context) {
    final provider = Provider.of<ReservationProvider>(context, listen: false);
    provider.addConferenceReservation(
      _selectedLocation!,
      _selectedRoomNumber!,
      _selectedDate!.toLocal().toString().split(' ')[0],
      _selectedTime!.format(context),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('회의실 예약이 완료되었습니다!')),
    );

    Navigator.pop(context); // 예약 후 이전 화면으로 이동
  }
}
