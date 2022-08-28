import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/ui/widgets/add_task_widget.dart';
import 'package:todo_app/ui/widgets/bottom_bar_widget.dart';
import 'package:todo_app/ui/widgets/custom_bottom_sheet_widget.dart';
import 'package:todo_app/ui/widgets/gradient_add_icon_widget.dart';
import 'package:todo_app/ui/widgets/tabs_widget.dart';

///Basic or home screen of the app.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groups, child) {
        return Scaffold(
          body: TabsWidget(),
          bottomNavigationBar: const BottomBarWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onPressed: () {
              showModalBottomSheet<Widget>(
                context: context,
                builder: (_) {
                  return const CustomBottomSheetWidget(
                    child: AddTaskWidget(),
                  );
                },
              );
            },
            child: const GradientAddIconWidget(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
