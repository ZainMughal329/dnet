import 'package:d_net/Screens/admin/controller.dart';
import 'package:get/get.dart';

class AdminBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}
