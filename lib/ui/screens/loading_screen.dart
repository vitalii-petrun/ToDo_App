import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.wait([
      Provider.of<TaskProvider>(context, listen: false).fetchAndSet(),
      Provider.of<GroupProvider>(context, listen: false).fetchAndSet()
    ]).whenComplete(
      () => Navigator.pushReplacementNamed(context, "/home_screen"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
