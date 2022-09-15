import 'package:flutter/material.dart';

void showToast(BuildContext context, String text){
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(text),
        elevation: 20,
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white,),
      )
  );
}