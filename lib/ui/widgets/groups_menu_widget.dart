import 'package:flutter/material.dart';

///Menu to navigate between groups and creating new group.
class GroupsMenuWidget extends StatelessWidget {
  ///Makes possible to create constant widget.
  const GroupsMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Groups List"),
      ],
    );
  }
}
