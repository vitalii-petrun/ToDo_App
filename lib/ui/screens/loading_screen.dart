import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

///Screen showed while data is loading.
class LoadingScreen extends StatefulWidget {
  ///Creates const screen.
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<TaskProvider>().fetchAndSet(),
      context.read<GroupProvider>().fetchAndSet()
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
