import 'package:d_net/Screens/SessionPages/SplashScreen/index.dart';
import 'package:d_net/Screens/SessionPages/Welcome/bindings.dart';
import 'package:d_net/Screens/SessionPages/Welcome/view.dart';
import 'package:d_net/Screens/UserScreens/homeScreen/bindings.dart';
import 'package:d_net/Screens/admin/homeScreen/bindings.dart';
import 'package:d_net/Screens/admin/homeScreen/view.dart';
import 'package:d_net/Screens/admin/userDetails/index.dart';
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
      name: RoutesNames.welcomeScreen,
      page: () => WelcomeScreen(),
      binding: WelcomeBindings(),
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
    GetPage(
      name: RoutesNames.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: RoutesNames.userDetailScreen,
      page: () => userDetailsScreen(),
      binding: userDetailsBindings(),
    ),
  ];
}
