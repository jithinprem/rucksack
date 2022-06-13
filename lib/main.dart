import 'package:flutter/material.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:rucksack/screens/logSignScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      initialRoute: LogSignScreen.id,

      routes: {
        HomeScreen.id : (context) => HomeScreen(),
        LogSignScreen.id : (context) => LogSignScreen(),
      },
    );
  }
}
