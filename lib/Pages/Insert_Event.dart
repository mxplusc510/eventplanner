
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventplanner/Model/events.dart';
import 'package:eventplanner/utils.dart';
import 'package:eventplanner/Provider/event_provider.dart';
import 'package:share/share.dart';

// 'package:event_calendar/event_calendar.dart';

class InsertEvent extends StatefulWidget {
  final Event? event;

  const InsertEvent({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  InsertEventState createState() => InsertEventState();
}

class InsertEventState extends State<InsertEvent> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();



  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      locationController.text = event.location;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      //insert event page layout
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          //create insert event form
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                insertEventTitle(),
                SizedBox(height: 12),
                insertEventLocation(),
                SizedBox(height: 12),
                insertEventDescription(),
                SizedBox(height: 12),
                DateTimePicker(),
              ],
            ),
          )));

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: saveForm,
            icon: const Icon(Icons.done),
            label: const Text('Save')),

      IconButton(icon: const Icon(Icons.share_outlined),
        onPressed: (){
          Share.share("http://play.google.com/store/apps/details?id=com.instructivetech.testapp");
        })
      ];



  Widget insertEventTitle() => TextFormField(
        style: const TextStyle(fontSize: 25),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Event Title',
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );
  Widget insertEventLocation() => TextFormField(
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Add Location',
    ),
    onFieldSubmitted: (_) => saveForm(),
    controller: locationController,
  );

  Widget insertEventDescription() => TextFormField(
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Add Description',
    ),
    onFieldSubmitted: (_) => saveForm(),
    controller: descriptionController,
  );
  Widget DateTimePicker() => Column(
        children: [
          pickFromDate(),
          pickToDate(),
        ],
      );

  Widget pickFromDate() => fromHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: dropDownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              flex: 1,
              child: dropDownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            )
          ],
        ),
      );
  Widget pickToDate() => toHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: dropDownField(
                text: Utils.toDate(toDate),
                onClicked: () => picktoDateTime(pickDate: true),
              ),
            ),
            Expanded(
              flex: 1,
              child: dropDownField(
                  text: Utils.toTime(toDate),
                  onClicked: () => picktoDateTime(pickDate: false)),
            )
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return null;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future picktoDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return null;

    if (date.isBefore(fromDate)) {
      fromDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2000, 8),
        lastDate: DateTime(2100),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget dropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget fromHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
          child,
        ],
      );
  Widget toHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
          child,
        ],
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
        title: titleController.text,
        location: locationController.text, // add location from text field
        description: descriptionController.text, // add description from text field
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );
      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
        Navigator.of(context).pop();
      } else {
        provider.addEvent(event);
      }

      Navigator.of(context).pop();
    }
  }





}
