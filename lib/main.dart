import 'package:eventplanner/Calendar_Widgets/calendar_layout.dart';
import 'package:flutter/material.dart';
import 'Pages/Insert_Event.dart';
import 'package:eventplanner/Provider/event_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'Calender';

  const MyApp({super.key});

  //declaring the themes for the MaterialApp
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,),

          home: const MainPage(),
        ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  //building the scaffold for the calendar app
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(MyApp.title),
          centerTitle: true,
        ),
        //display calendar from CalendarLayout
        body: const CalendarLayout(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () =>Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const InsertEvent()),
          ),
          child: const Icon(Icons.add, color: Colors.white)),
      );
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({required Key key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: new Center(
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             new Text(
//               'You have pushed the button this many times:',
//             ),
//             new Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: new Icon(Icons.add),
//       ),
//     );
//   }
// }
