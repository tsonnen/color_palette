import 'package:flutter/material.dart';

class NameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return AlertDialog(
      title: Text('Enter a Name'),
      content: TextField(
        controller: nameController,
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.of(context).pop(nameController.text);
          },
        )
      ],
    );
  }
}