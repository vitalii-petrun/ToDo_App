import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/providers/group_provider.dart';

///Screen for creating new group.
class CreateGroupScreen extends StatefulWidget {
  ///Makes possible to create constant screen.
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _titleCtrl = TextEditingController();

  String _titleBuff = "";

  @override
  void initState() {
    _titleCtrl.addListener(() {
      _titleBuff = _titleCtrl.text;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<GroupProvider>(context, listen: false).add(
                Group(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: _titleBuff,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: const Text(
          "Group creating",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Type group's title",
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: _titleCtrl,
              //initialValue: "Type group name",
            ),
          ),
        ],
      ),
    );
  }
}
