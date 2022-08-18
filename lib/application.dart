import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/home.dart';

///App entry.
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
