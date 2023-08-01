import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{

  // This method is used to show toast messages
  static showToastMessage(String hasError) {
    Fluttertoast.showToast(
      msg: hasError,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: lightGreenColor,
      textColor: blackColor,
      fontSize: 14.0,
    );
  }
}