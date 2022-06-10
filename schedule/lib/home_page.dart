// ignore_for_file: unnecessary_this, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/model/event.dart';
import 'package:schedule/service/event_service.dart';
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
  String? eventText;
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

    return Consumer<EventService>(
      builder: (context, eventService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  eventService.clearEvents();
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                onPressed: () {
                  eventService.showAllEvents();
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.indigo,
                ),
              )
            ],
          ),
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
                      Event? event = eventService.findEvent(selectedDay);
                      if (event != null) {
                        eventText = event.event;
                      }
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
              Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  eventText == null ? "등록된 이벤트가 없습니다." : eventText!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () {
              showCustomDialog(
                context,
                Text("일기작성"),
                [
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
                      eventService.createEvent(
                          _selectedDay!, textEditingController.text);
                      eventService.showAllEvents();
                      this.textEditingController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "확인",
                      style: dialogStyle,
                    ),
                  ),
                ],
              );
            },
            child: Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
