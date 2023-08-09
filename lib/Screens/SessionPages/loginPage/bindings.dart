import 'package:get/get.dart';

import 'controller.dart';

class loginBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<loginController>(() => loginController());
  }
}
