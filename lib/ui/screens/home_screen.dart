import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/widgets/add_task_widget.dart';
import 'package:todo_app/ui/widgets/bottom_bar_widget.dart';
import 'package:todo_app/ui/widgets/custom_bottom_sheet_widget.dart';
import 'package:todo_app/ui/widgets/task_list_widget.dart';

///Basic or home screen of the app.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//await Provider.of<TaskProvider>(context, listen: false).fetchAndSet();

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isLoading == true) {
      Future.wait([
        Provider.of<TaskProvider>(context, listen: false).fetchAndSet(),
      ]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

/* DefaultTabController(
      length: _groups.length,
      child: */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        toolbarHeight: 0,
        centerTitle: true,
        /*  bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            tabs: _groups
                .map(
                  (text) => Tab(
                    text: text,
                  ),
                )
                .toList(),
          ), */
      ),
      body: Consumer<TaskProvider>(
        builder: (context, data, child) {
          return TaskListWidget(tasks: data.items);
        },
      ),
      bottomNavigationBar: const BottomBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Widget>(
                  context: context,
                  builder: (context) {
                    return const CustomBottomSheetWidget(
                      child: AddTaskWidget(),
                    );
                  },
                );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
