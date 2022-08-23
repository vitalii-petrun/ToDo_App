import 'package:flutter/material.dart';

///Screen for creating new group.
class CreateGroupScreen extends StatefulWidget {

  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _titleCtrl = TextEditingController();

  String titleBuff = "";

  @override
  void initState() {
    _titleCtrl.addListener(() {
      titleBuff = _titleCtrl.text;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        toolbarHeight: 0,
        centerTitle: true,
        title: const Text("Group creating"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleCtrl,
            initialValue: "Type group name",
          ),
        ],
      ),
    );
  }
}
