import 'package:flutter/material.dart';
import 'package:sanjivani/screens/screens.dart';
import 'screens/dashboard.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      Center(child: CircularProgressIndicator());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanjivani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Dashboard(),
    );
  }
}
