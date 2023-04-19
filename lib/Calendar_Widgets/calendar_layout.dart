import 'package:eventplanner/Calendar_Widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:eventplanner/Provider/event_provider.dart';
import 'package:eventplanner/Model/eventsDateSource.dart';

class CalendarLayout extends StatelessWidget {
  const CalendarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      dataSource: EventsDataSource(events),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(context: context, builder: (context) => TaskLayout());
      },
    );
  }
}
