import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true ,
      announcement:  true ,
      badge: true ,
      carPlay: true ,
      criticalAlert: true ,
      provisional: true ,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission Granted');
      print("granted automatically");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Provisional permissions granted');
    }else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('DENIED');
    }
  }

  Future<String> getDeviceToken() async{
    String? token =  await messaging.getToken();
    return token!;
  }
    void isTokenRefresh(){
    messaging.onTokenRefresh.listen((event) {
    print(event.toString()) ;
    })
    ;
  }
}