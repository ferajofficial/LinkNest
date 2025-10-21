import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/firebase_options.dart';
import 'package:link_nest/splasher.dart';

/// This entry point should be used for production only
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  runApp(
    const ProviderScope(child: Splasher()),
  );
}

/*
    1. Add push notification system [Firebase Push Notification]
            While App is ni sleep/on/background.
    2. Add folder system.
    3. Add search system.
    4. Add Tagging system.
          [Youtube,Website,posts,drive etc.]

 */