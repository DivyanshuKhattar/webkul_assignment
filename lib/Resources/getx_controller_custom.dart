import 'package:get/get.dart';

class GetXControllerCustom extends GetxController {

  final cart = 0.obs;
  increment() => cart.value++;
  decrement() => cart.value--;

}