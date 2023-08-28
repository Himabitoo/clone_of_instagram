import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:clone_of_instagram/config.dart';
import 'package:clone_of_instagram/screens/login_screen.dart';
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            }else if (snapshot.hasError){

              return Center(child: Text('${snapshot.error }'),);

            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
