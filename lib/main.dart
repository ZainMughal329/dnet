import 'package:d_net/Utilities/ReusableComponents/reuseableTextFormField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:timezone/browser.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'Utilities/ReusableComponents/constants.dart';
import 'Utilities/Routes/routes.dart';
import 'Utilities/Routes/routesNames.dart';
import 'Utilities/services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessangingBackgroundHandler);
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    '1',
    'notificationTask',
    inputData: <String, dynamic>{},
    frequency: Duration(hours: 1), // Adjust frequency as needed
  );

  runApp(const MyApp());

}
@pragma('vm:entry-point')
Future<void> _FirebaseMessangingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationServices services =
    NotificationServices();
    await services.fetchDataAndScheduleNotifications();
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      initialRoute: RoutesNames.splashScreen,
      getPages: AppPages.routes,
      // home: MyForm(),
    );
  }
}
