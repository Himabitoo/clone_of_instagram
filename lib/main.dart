import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:clone_of_instagram/config.dart';
import 'package:clone_of_instagram/screens/login_screen.dart';
import 'package:clone_of_instagram/screens/signup_screnn.dart';
import 'package:clone_of_instagram/utils/colors.dart';
import 'package:clone_of_instagram/responsive/web_screen_layout.dart';
import 'package:clone_of_instagram/responsive/mobile_screen_layout.dart';
import 'package:clone_of_instagram/responsive/responsive_layout_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  if (kIsWeb) {
    // when Web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: FirebaseConfig.Web_apiKey,
        appId: FirebaseConfig.Web_appId,
        projectId: FirebaseConfig.Web_projectId,
        messagingSenderId: FirebaseConfig.Web_messagingSenderId,
        authDomain: FirebaseConfig.Web_authDomain,
        storageBucket: FirebaseConfig.Web_storageBucket,
      ),
    );
  } else {
    // when Native
    await Firebase.initializeApp();
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: FirebaseConfig.Native_apiKey,
    //     appId: FirebaseConfig.Native_appId,
    //     projectId: FirebaseConfig.Native_projectId,
    //     messagingSenderId: FirebaseConfig.Native_messagingSenderId,
    //     authDomain: FirebaseConfig.Native_authDomain,
    //     storageBucket: FirebaseConfig.Native_storageBucket,
    //   ),
    // );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: SignUpScreen(),
    );
  }
}
