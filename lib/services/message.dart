import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

successMessage({String? message}) {
  Fluttertoast.showToast(
    webShowClose: false,
    msg: message!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.green[800],
    textColor: Colors.white,
    // fontSize: 15.0,
  );
}

errorMessage({String? message}) {
  Fluttertoast.showToast(
    webShowClose: false,
    msg: message!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red[800],
    textColor: Colors.white,
    // fontSize: 15.0,
  );
}
