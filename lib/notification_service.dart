import 'package:aadarsh_pvt_ltd/ui/screens/notification_data/ui/notification_data_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

class NotificationService{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }
  Future<void> initialize() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      _handleMessage(message);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _handleMessage(message);
      }
    });
  }


  void _handleMessage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      String targetScreen = message.data['screen'];
      String? id = message.data['id'];

      // Navigation logic based on screen name
      if (targetScreen == 'details') {
        Get.to(() => NotificationDataScreen()); // Example using GetX
      } else if (targetScreen == 'home') {
        Get.to(() => NotificationDataScreen());
      }
    }
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    return token;
  }


  // Request notification permission
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.request().isGranted) {
      // Permission is granted
      print('Notification permission granted');
    } else {
      // Permission is denied
      print('Notification permission denied');
    }
  }

  // Listen for incoming messages
  void listenForMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 Received a message in the foreground!');
      print('🔹 Message Data: ${message.data}');
      if (message.notification != null) {
        print('🔔 Notification Title: ${message.notification!.title}');
        print('📄 Notification Body: ${message.notification!.body}');
        print('📱 Notification Android Details: ${message.notification!.android}');
        showFlutterNotification(message);
      } else {
        print('⚠️ Message has no notification.');
      }
    });
  }

  void showFlutterNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'clicit_es',
        'Clic it notification services',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        icon: '@drawable/ic_notification', // <-- IMPORTANT
      );

      NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
      );

      print('✅ Notification displayed using flutter_local_notifications');
    } else {
      print('❌ Notification or Android config is null');
    }
  }
}

