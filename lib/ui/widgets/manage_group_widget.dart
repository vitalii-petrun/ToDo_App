import 'package:flutter/material.dart';

///Widget to manage(delete, rename) group.
class ManageGroupWidget extends StatelessWidget {
  ///Makes possible to create constant widget.
  const ManageGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Manage selected group"),
      ],
    );
  }
}
