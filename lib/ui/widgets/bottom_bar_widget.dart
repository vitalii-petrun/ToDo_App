import 'package:flutter/material.dart';

import 'package:todo_app/ui/widgets/custom_bottom_sheet_widget.dart';

import 'package:todo_app/ui/widgets/groups_menu_widget.dart';

///Bottom bar with place for FAB.
class BottomBarWidget extends StatelessWidget {
  static const double _barHeight = 50;

  ///Creates constant widget.
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _barHeight,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet<Widget>(
                  context: context,
                  builder: (context) {
                    return const CustomBottomSheetWidget(
                      child: GroupsMenuWidget(),
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
