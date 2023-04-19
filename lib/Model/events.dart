import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final String location;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightBlueAccent,
    this.isAllDay = false,
    required this.location,
  });

  String get date => '${from.day}/${from.month}/${from.year}';

  String get time => '${from.hour}:${from.minute} - ${to.hour}:${to.minute}';
}
