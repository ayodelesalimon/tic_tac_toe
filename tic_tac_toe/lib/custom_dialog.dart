import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final title;
  final content;
  final actionText;
  final VoidCallback callback;

  CustomDialog( this.title, this.content, this.callback, [this.actionText = "Reset"]) ;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(onPressed: callback,
            child: Text(actionText)),
      ],
    );
  }
}
