import 'package:eventplanner/Model/eventsDateSource.dart';
import 'package:eventplanner/Provider/event_provider.dart';
import 'package:eventplanner/Pages/ViewEvent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:eventplanner/Pages/ViewEvent.dart';
import 'package:eventplanner/Model/events.dart';
import 'dart:math';


//a pop up widget that shows the events on selected day
class TaskLayout extends StatefulWidget {
  @override
  TaskLayoutState createState() => TaskLayoutState();
}

class TaskLayoutState extends State<TaskLayout> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return const Center(
          child: Text(
            'No events set!',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ));
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
          timeTextStyle: const TextStyle(fontSize: 15, color: Colors.black)),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventsDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.2),
        ),
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewEventPage(event: event)));
        },
      ),
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.toList()[0] as Event;
    final randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.5);
    return Container(
      width: details.bounds.width,
      height: details.bounds.width,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
