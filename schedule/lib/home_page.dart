import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TextEditingController textEditingController = TextEditingController();

  void showCustomDialog(context, title, actions) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          actions: actions,
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "한 줄 일기를 작성해주세요.",
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle dialogStyle = TextStyle(
      color: Colors.indigo,
    );

    List<Widget> actions = [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "취소",
          style: dialogStyle,
        ),
      ),
      TextButton(
        onPressed: () {
          print(textEditingController.text);
          textEditingController.clear();
          

          Navigator.pop(context);
        },
        child: Text(
          "확인",
          style: dialogStyle,
        ),
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          showCustomDialog(
            context,
            Text("일기작성"),
            actions,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
