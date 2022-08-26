import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
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

//await Provider.of<TaskProvider>(context, listen: false).fetchAndSet(); TODO

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //late TabController _tabController;

  /*  @override
  void initState() {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    void _setActiveTabIndex() {
      groupProvider.tabIndex = _tabController.index;
    }

    print("initState ${groupProvider.items.length}");
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: Provider.of<GroupProvider>(context, listen: false).items.length,
    );
    _tabController.addListener(_setActiveTabIndex);
  } */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.wait([
      Provider.of<TaskProvider>(context, listen: false).fetchAndSet(),
      Provider.of<GroupProvider>(context, listen: false).fetchAndSet(),
    ]);
  }

  /*  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groups, child) {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        final groupProvider =
            Provider.of<GroupProvider>(context, listen: false);

        return DefaultTabController(
          length: groupProvider.items.length,
          child: Builder(builder: (context) {
            final tabController = DefaultTabController.of(context)!;
            tabController.addListener(() {
              groupProvider.tabIndex = tabController.index;
            });

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
                toolbarHeight: 0,
                centerTitle: true,
                bottom: TabBar(
                  //controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  tabs: groups.items
                      .map(
                        (group) => Tab(
                          text: group.title,
                        ),
                      )
                      .toList(),
                ),
              ),
              body: Consumer<TaskProvider>(
                builder: (context, data, child) {
                  return TabBarView(
                    //controller: _tabController,
                    children: groupProvider.items
                        .map(
                          (group) => TaskListWidget(
                            tasks: taskProvider.itemsByGroup(group.title),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              bottomNavigationBar: const BottomBarWidget(),
              floatingActionButton: FloatingActionButton(
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
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          }),
        );
      },
    );
  }
}
