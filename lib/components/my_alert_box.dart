import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {

  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({Key? key, this.controller, required this.onSave, required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
  controller: controller,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.grey[100],
          child: const Text('Save'),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.grey[100],
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
