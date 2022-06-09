import 'package:flutter/material.dart';

class EventService extends ChangeNotifier {
  Map events = {'2020-02-02': '좋은 날'};

  void createEvent(DateTime dateTime, String event) {
    events[dateTime] = event;
  }
}
