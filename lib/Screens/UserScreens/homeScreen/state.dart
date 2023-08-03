import 'package:get/get.dart';

class UserState {
  RxInt remainingDays = 0.obs;
  Rx<DateTime> startDateTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDateTime = Rx<DateTime>(DateTime.now());
  RxBool loading = false.obs;
}