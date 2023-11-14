import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text) => Fluttertoast.showToast(    //Alaa
    msg: text,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red.shade700,
    textColor: Colors.white,
    fontSize: 16.0);
