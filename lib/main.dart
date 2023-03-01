import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/Screens/logInScreens/logInScreen.dart';
import 'package:instaclone/provider/user_provider.dart';
import 'package:instaclone/responsive/mobileScreenLayout.dart';
import 'package:instaclone/responsive/responsiveLayout.dart';
import 'package:instaclone/responsive/webScreenLayout.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyA5wCDzmmm-ojSYyIukkT9K1i1ypzYMK80',
      appId: "1:815194367212:web:85bfac101f8c0303cb71c9",
      messagingSenderId: "815194367212",
      projectId: "instagramcloneapp-f6914",
      storageBucket: "instagramcloneapp-f6914.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Instagram_clone App",
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: PrimaryColor),
                );
              }
              return LogInScreen();
            },
          )
          // LogInScreen()

          ),
    );
  }
}
