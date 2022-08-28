import 'package:flutter/material.dart';

///Widget which displayed when group doesn't contain any item.
class NoTasksWidget extends StatelessWidget {
  ///Creates constant widget.
  const NoTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff49BCF6),
                Color(0xff1E2A78),
              ],
            ).createShader(bounds),
            child: Column(
              children: [
                Image.asset('assets/images/no_tasks.png'),
              ],
            ),
          ),
          const Text(
            "There is no tasks",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Add a task by pressing plus button",
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
          )
        ],
      ),
    );
  }
}
