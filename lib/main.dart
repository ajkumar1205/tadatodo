import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './firebase_options.dart';
import './theme/colors.dart';
import './pages/auth_page.dart';
import './pages/home_page.dart';
import './pages/edit_page.dart';
import './provider/auth/auth_cubit.dart';
import './provider/notes/notes_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<NoteCubit>(create: (create) => NoteCubit()),
      ],
      child: MaterialApp(
        title: 'Tada Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: pColor),
          useMaterial3: true,
        ),
        initialRoute:
            FirebaseAuth.instance.currentUser != null ? "/home" : "/auth",
        routes: {
          "/home": (context) => const HomePage(),
          "/auth": (context) => const AuthPage(),
          "/edit": (context) => const EditPage()
        },
      ),
    );
  }
}
