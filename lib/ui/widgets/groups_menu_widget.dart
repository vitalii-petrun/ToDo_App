import 'package:flutter/material.dart';
import 'package:todo_app/models/group.dart';

///Menu to navigate between groups and creating new group.
class GroupsMenuWidget extends StatelessWidget {
  ///Groups list.
  List<Group> groups;
  ///Receives groups list.
   GroupsMenuWidget({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        
        Text("Groups List"),
        Divider(),

        
      ],
    );
  }
}
