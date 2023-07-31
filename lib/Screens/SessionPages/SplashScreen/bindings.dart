import 'package:d_net/Screens/SessionPages/SplashScreen/controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(() => SplashController());
  }

}