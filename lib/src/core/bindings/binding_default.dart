import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_auth.dart';

class BindingDefault implements Bindings {
  @override
  void dependencies() {
    Get.put(ControllerAuth());
  }
}
