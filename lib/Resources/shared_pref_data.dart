import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData{

  String userId = "userId";
  String isLoggedIn = "isLoggedIn";
  String cartValue = "cartValue";

  /// user id
  Future setUserId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userName', value);
  }

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(userId);
    return intValue ?? 0;
  }

  /// is user logged in
  Future setIsLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(isLoggedIn);
    return boolValue ?? false;
  }

  /// cart value
  Future setCartValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartValue', value);
  }

  Future getCartValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(cartValue);
    return intValue ?? 0;
  }
}