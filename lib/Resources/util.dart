import 'package:dummy_assignment/CommonClasses/common_function.dart';
import 'package:dummy_assignment/CommonClasses/custom_toast.dart';
import 'package:dummy_assignment/Resources/string_constants.dart';
import 'package:dummy_assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Util{

  /// function for GET PRODUCT LIST DATA api calling
  static Future getProductListData() async {
    try {
      var result = await CommonFunction().checkNetwork();
      if(result == true){
        var response = await http.get(Uri.parse("${baseUrl}products"));
        return response.body;
      }
      else{
        CustomToast.showToastMessage(StringConstants().noNetwork);
      }
    } catch (e) {
      debugPrint('GET PRODUCT LIST failed: $e');
    }
  }

  /// function for GET PRODUCT DETAIL api calling
  static Future getProductDetail(int id) async {
    try {
      var result = await CommonFunction().checkNetwork();
      if(result == true){
        var response = await http.get(Uri.parse("${baseUrl}products/$id"));
        return response.body;
      }
      else{
        CustomToast.showToastMessage(StringConstants().noNetwork);
      }
    } catch (e) {
      debugPrint('GET PRODUCT DETAIL failed: $e');
    }
  }

}