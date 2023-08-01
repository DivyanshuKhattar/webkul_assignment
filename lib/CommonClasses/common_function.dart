import 'dart:io';
import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonFunction{

  /// for light status bar color
  static lightStatusBarColor(Color color) async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: color,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  /// for dark green status bar color
  static darkGreenStatusBarColor() async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: greenColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: greenColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  /// checking network before calling api
  Future<bool> checkNetwork() async{
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  }
}