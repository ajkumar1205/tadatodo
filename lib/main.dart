import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import './theme/colors.dart';
import './pages/auth_page.dart';
import './pages/home_page.dart';
import './pages/edit_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tada Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: pColor),
        useMaterial3: true,
      ),
      routes: {
        "/home": (context) => const HomePage(),
        "/": (context) => const AuthPage(),
        "/edit": (context) => const EditPage()
      },
    );
  }
}
