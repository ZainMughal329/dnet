import 'package:d_net/Screens/UserScreens/homeScreen/controller.dart';
import 'package:get/get.dart';

class UserBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
