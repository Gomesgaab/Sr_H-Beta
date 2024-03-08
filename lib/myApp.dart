import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pagesLogin/login_page_Menu.dart';
import 'package:flutter_srh_application/pages/pages_home/mainPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //PrimaryColor (cor principal da aplicação)
          //Fonte/estilo de texto principal
          useMaterial3: true,
          primaryColor: const Color.fromARGB(145, 200, 228, 1000),
      ),
      home: const RoteadorTela(),
    );
  }
}
class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MainPage();
        } else {
          return const LoginPageMenu();
        }
      },
    );
  }
}