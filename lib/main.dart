import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/controller/auth_controller/change_password_controller.dart';
import 'package:foodfinder/controller/auth_controller/login_controller.dart';
import 'package:foodfinder/controller/auth_controller/signup_controller.dart';
import 'package:foodfinder/controller/edit_profile_controller/edit_profle_controller.dart';
 import 'package:foodfinder/firebase_options.dart';
import 'package:foodfinder/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => EditProfileController()),
        ChangeNotifierProvider(create: (_)=> ChangePasswordController()),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Finder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
