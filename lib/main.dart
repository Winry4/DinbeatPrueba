import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/src/view/Home.dart';
import 'package:firebase_test/src/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'utils/App_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: App_theme.buildLightTheme().primaryColor,
                fontFamily: 'Montserrat',
              ),
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User? user = snapshot.data;
                return Home(uid: user!.uid);
              } else {
                return LoginScreen();
              }
            }));
  }
}
