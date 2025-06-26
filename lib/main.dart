import 'package:flutter/material.dart';
import 'app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'notification_service.dart';

NotificationService notificationService = NotificationService();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await notificationService.initializeFirebase();
  await notificationService.getToken();
  await notificationService.initialize();

  runApp(const MyApp());
}


