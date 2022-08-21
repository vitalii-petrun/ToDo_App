import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/bottom_bar_widget.dart';

///Basic or home screen of an app.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const _groups = ["home", "work"];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _groups.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          toolbarHeight: 0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            tabs: _groups
                .map(
                  (text) => Tab(
                    text: text,
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _groups
              .map(
                (e) => Center(
                  child: Text(e),
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: const BottomBarWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
