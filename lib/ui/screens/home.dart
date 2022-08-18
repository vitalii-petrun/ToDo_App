import 'package:flutter/material.dart';

///Basic or home screen of an app.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

const _groups = ["home", "work"];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _groups.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
