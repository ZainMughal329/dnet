import 'package:get/get.dart';

import 'controller.dart';

class AddUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUserController>(() => AddUserController());
  }
}
