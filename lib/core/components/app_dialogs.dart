import 'package:flutter/material.dart';

Future<void> appDialog({required BuildContext context,required Widget children,Text? title, Widget? actions,bool barrierDismissible = true}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible, // by default dialog is cancelable.
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
            children: [children],
          ),
        ),
        actions: [?actions],
      );
    },
  );
}