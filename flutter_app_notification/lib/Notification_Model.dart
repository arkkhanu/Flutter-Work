import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification_Model {
  static Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
      enableVibration: true);


  static getMessageListen(FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin) {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'ic_launcher',
                priority: Priority.high,
                importance: Importance.max,
                // icon: 'launch_background',
              ),
            ));
      }
    });
  }
}
