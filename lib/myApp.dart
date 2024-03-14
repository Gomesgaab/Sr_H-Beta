import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pageLogin/LoginPage.dart';

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
        primaryColor: Color.fromARGB(145, 0, 0, 0),
        fontFamily: 'RobotoCondensed',
      ),
      home: const LoginPage(),
    );
  }
}


