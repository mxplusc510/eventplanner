import 'package:flutter/material.dart';
import 'package:eventplanner/Model/events.dart';
import 'package:eventplanner/Pages/Insert_Event.dart';

class ViewEventPage extends StatelessWidget {
  final Event event;

  ViewEventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Add code to delete the event
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Date: ${event.date}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Time: ${event.time}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Location: ${event.location}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              event.description,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the InsertEvent page to edit the event
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertEvent(
                event: event,
              ),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
