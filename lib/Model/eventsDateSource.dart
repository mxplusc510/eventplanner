import 'package:eventplanner/Model/events.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventsDataSource extends CalendarDataSource {
  EventsDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  //get index from list and access Event instead dynamic object
  //structure as shown in events.dart
  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
