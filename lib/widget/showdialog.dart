import 'package:flutter/material.dart';

showAlertDialogCustom(
    {required BuildContext context,
    required String name,
    required VoidCallback cancel,
    required VoidCallback yess}) {
  // set up the buttons
  Widget cancelButton = TextButton(child: Text("Cancel"), onPressed: cancel);
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: yess,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Perhatian!"),
    content: Text("Apakah Data $name mau di hapus?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
