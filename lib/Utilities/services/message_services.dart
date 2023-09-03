import 'package:d_net/Utilities/ReusableComponents/utilis.dart';
import 'package:flutter_sms/flutter_sms.dart';

class MessagesService {
  String message =
      "Pay Your Internet Bill to enjoy unlimited internet service\nDubai Sky Net";


   Future<void> sendMessage(List<String> recipients) async {
    await sendSMS(message: message, recipients: recipients,sendDirect: true).then((value){

      Utils.showToast("Message Sent");

    }).onError((error, stackTrace){
      Utils.showToast(error.toString());
      print("Error while sending Message :" + error.toString());

    });
  }
}
