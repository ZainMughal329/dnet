import 'package:d_net/Screens/admin/userDetails/controller.dart';
import 'package:get/get.dart';

class userDetailsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<userDetailsController>(() => userDetailsController());
  }
}
