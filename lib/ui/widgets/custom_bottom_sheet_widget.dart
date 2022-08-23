import 'package:flutter/material.dart';

///Custom bottom sheet with padding for keyboard.
class CustomBottomSheetWidget extends StatelessWidget {

  ///The widget below this widget in the tree.
  final Widget child;

  ///Creates bottom sheet with padding for keyboard and child.
  const CustomBottomSheetWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
        ],
      ),
    );
  }
}
