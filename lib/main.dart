import 'package:flutter/material.dart';

import 'app.dart';
import 'notification_service.dart';

void main() async{
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Notification Service
  NotificationService notificationService = NotificationService();
  // Initialize Firebase
  await notificationService.initializeFirebase();
  await notificationService.getToken();
  await notificationService.initialize();

  runApp(const MyApp());
}



