import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/screens/create_group_screen.dart';
import 'package:todo_app/ui/screens/home_screen.dart';
import 'package:todo_app/ui/screens/loading_screen.dart';

///App entry.
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/loading_screen',
        routes: {
          "/loading_screen": (context) => const LoadingScreen(),
          "/home_screen": (context) => HomeScreen(),
          "/create_group_screen": (context) => const CreateGroupScreen(),
        },
      ),
    );
  }
}
