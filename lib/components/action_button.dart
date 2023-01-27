import 'package:flutter/material.dart';

class creatingActionButton extends StatelessWidget {

  final Function() onPressed;

  const creatingActionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.deepPurpleAccent,
      child: const Icon(Icons.add),
    );
  }
}
