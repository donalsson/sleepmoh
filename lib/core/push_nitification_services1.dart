import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      // request permissions if we're on android
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = prefs.get('FCMToken');
      if (userToken == null) {
        _fcm.getToken().then((val) async {
          print('Token: '+val);
          prefs.setString('FCMToken', val);        
        });
      }else{
        print('Token: '+userToken);
      }

    _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      // Called when the app has been closed comlpetely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _serialiseAndNavigate(message);
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _serialiseAndNavigate(message);
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
       // _navigationService.navigateTo(CreatePostViewRoute);
      }
    }
  }
}