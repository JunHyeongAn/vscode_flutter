import 'package:flutter/material.dart';
import 'package:schedule/model/event.dart';

class EventService extends ChangeNotifier {
  Map events = {};

  void createEvent(DateTime dateTime, String event) {
    events[dateTime] = event;
    notifyListeners();
  }

  void testEventService() {
    print("event service is running!");
  }

  void showAllEvents() {
    print(events);
  }

  void clearEvents() {
    events.clear();
    notifyListeners();
  }

  Event? findEvent(DateTime dateTime) {
    String? eventText = events[dateTime];

    Event event = Event(eventText, dateTime);

    return event;
  }
}
