import 'package:flutter/material.dart';

void showMessageDialog(BuildContext context,
    {required String message,
    String? postButtonTitle,
    VoidCallback? postButtonAction,
    String? negativeButtonTitle,
    VoidCallback? negativeButtonAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (postButtonTitle != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          postButtonAction?.call();
        },
        child: Text(postButtonTitle)));
  }
  if (negativeButtonTitle != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negativeButtonAction?.call();
        },
        child: Text(negativeButtonTitle)));
  }
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(content: Text(message), actions: actions);
      },
    barrierDismissible: isCancelable,
  );
}

void showLoadingDialog(BuildContext context,
    {required String message, bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 12,
              ),
              Text(message)
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoading(BuildContext context){
  Navigator.pop(context);
}
