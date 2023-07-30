import 'package:d_net/Screens/UserScreens/homeScreen/bindings.dart';
import 'package:d_net/Screens/admin/bindings.dart';
import 'package:d_net/Screens/admin/view.dart';
import 'package:d_net/Utilities/Routes/routesNames.dart';
import 'package:get/get.dart';

import '../../Screens/SessionPages/loginPage/bindings.dart';
import '../../Screens/SessionPages/loginPage/view.dart';
import '../../Screens/SessionPages/signUpPage/bindings.dart';
import '../../Screens/SessionPages/signUpPage/view.dart';
import '../../Screens/UserScreens/homeScreen/view.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesNames.loginScreen,
      page: () => LoginScreen(),
      binding: loginBindings(),
    ),
    GetPage(
      name: RoutesNames.signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: RoutesNames.userScreen,
      page: () => UserView(),
      binding: UserBindings(),
    ),
    GetPage(
      name: RoutesNames.adminScreen,
      page: () => AdminView(),
      binding: AdminBindings(),
    ),
  ];
}
