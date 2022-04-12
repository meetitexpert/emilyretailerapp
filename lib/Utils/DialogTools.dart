import 'package:flutter/material.dart';
import 'ConstTools.dart';

class DialogTools {
  static alertDialg(
      String button, String title, String message, context) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title == "" ? null : Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  child: Text(button),
                  onPressed: () {
                    Navigator.pop(context, 1);
                  }),
            ],
          );
        });

    return result;
  }

  static alertMultiloginDialg(
      String button, String title, String message, context) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title == "" ? null : Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  child: Text(button),
                  onPressed: () {
                    Navigator.pop(context, 1);
                    ConstTools.signOutHandling(context);
                  }),
            ],
          );
        });

    return result;
  }

  static alertDialgTwoButtons(String button1, String button2, String title,
      String message, context) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  child: Text(button1),
                  onPressed: () {
                    Navigator.pop(context, 1);
                    if (button1 == ConstTools.signOUt) {
                      //signout handling
                      ConstTools.signOutHandling(context);
                    }
                  }),
              TextButton(
                  child: Text(button2),
                  onPressed: () {
                    Navigator.pop(context, 2);
                  }),
            ],
          );
        });

    return result;
  }
}
