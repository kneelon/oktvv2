
import 'package:flutter/material.dart';


class CustomFloatingActionButton extends StatelessWidget {
  final Function onPress;
  const CustomFloatingActionButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onPress.call();
      },
      backgroundColor: Colors.white,
      elevation: 10,
      shape: const CircleBorder(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
          child: Image.asset('assets/images/app_icon.png')),
    );
  }
}
