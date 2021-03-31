import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_notification/SecondScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Notification_Model.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message?.messageId.toString()}');

}



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(Notification_Model.channel);
  
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  Notification_Model.getMessageListen(flutterLocalNotificationsPlugin);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: "/",
      routes: {
        "/SecondScreen":(context)=> SecondScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Column(
        children: [Text("ABC")
        ,
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, "/SecondScreen");
          }, child: Text("Move"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         String? token = await Notification_Model.getToken();
          print("Token ID:" + token.toString());
        },
      ),
    );
  }
}
