import 'package:flutter/material.dart';

///Linear gradient "add" icon.
class GradientAddIconWidget extends StatelessWidget {
  ///Constant constructor.
  const GradientAddIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 73, 188, 246),
          Color.fromARGB(255, 73, 147, 184),
          Color.fromARGB(255, 30, 42, 120),
        ],
      ).createShader(bounds),
      child: const Icon(
        Icons.add,
        size: 45,
      ),
    );
  }
}
