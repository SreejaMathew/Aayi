import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/add_subscription_screen.dart';

Future<void> main() async {
  // ✅ Ensures all bindings and plugins are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase with the configuration from firebase_options.dart
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Run the main app
  runApp(const AayiApp());
}

class AayiApp extends StatelessWidget {
  const AayiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aayi - Routine Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // ✅ Start with LoginScreen, but we define routes for navigation
      home: const AddSubscriptionScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/add-subscription': (context) => const AddSubscriptionScreen(),
      },
    );
  }
}
