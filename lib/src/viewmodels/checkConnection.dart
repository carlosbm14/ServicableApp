import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CheckConecction {
  Future<bool> isOnline(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        Toast.show(
          "No posee conexión a internet",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.85),
        );
        return false;
      }
    } on SocketException catch (_) {
      Toast.show(
        "No posee conexión a internet",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.85),
      );
      return false;
    }
  }
}