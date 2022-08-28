import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/widgets/done_tasks_tile_widget.dart';
import 'package:todo_app/ui/widgets/no_tasks_widget.dart';
import 'package:todo_app/ui/widgets/task_list_widget.dart';

///Widget which shows TabBar and TabBarView widgets with data from DB.
class TabsWidget extends StatefulWidget {
  @override
  _TabsWidgetWidgetState createState() => _TabsWidgetWidgetState();
}

class _TabsWidgetWidgetState extends State<TabsWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    final groupProvider = context.read<GroupProvider>();
    super.initState();
    _tabController = TabController(
      length: groupProvider.items.length,
      initialIndex: 0,
      vsync: this,
    );

    void _setActiveTabIndex() {
      groupProvider.tabIndex = _tabController.index;
    }

    _tabController.addListener(_setActiveTabIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.wait([
      context.read<TaskProvider>().fetchAndSet(),
      context.read<GroupProvider>().fetchAndSet(),
    ]);
  }

  @override
  void didUpdateWidget(covariant TabsWidget oldWidget) {
    final groupProvider = context.read<GroupProvider>();
    void _setActiveTabIndex() {
      groupProvider.tabIndex = _tabController.index;
    }

    super.didUpdateWidget(oldWidget);
    if (groupProvider.items.length != _tabController.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: groupProvider.items.length,
        initialIndex: max(
          0,
          groupProvider.items.length - 1,
        ),
        vsync: this,
      );
      groupProvider.tabIndexAfterRebuild = _tabController.index;
      _tabController.addListener(_setActiveTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groups, child) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    //This is for bottom border.
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.1),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 5, right: 10),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Theme.of(context).primaryColorDark,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                      controller: _tabController,
                      tabs: groups.items
                          .map((group) => Tab(text: group.title))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Consumer<TaskProvider>(
                builder: (context, tasks, child) {
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: groups.items.map(
                        (group) {
                          return tasks
                                  .itemsByGroup(
                                    groups.items[groups.tabIndex].title,
                                  )
                                  .isEmpty
                              ? const NoTasksWidget()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Column(
                                    children: [
                                      TaskListWidget(
                                        tasks: tasks
                                            .itemsByGroup(group.title)
                                            .where(
                                              (task) => task.isDone == false,
                                            )
                                            .toList(),
                                      ),
                                      DoneTasksTileWidget()
                                    ],
                                  ),
                                );
                        },
                      ).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
