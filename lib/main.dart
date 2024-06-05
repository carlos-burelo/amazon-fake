import 'package:amazon_fake/db/main.dart';
import 'package:amazon_fake/pages/checkout_page.dart';
import 'package:amazon_fake/pages/home_page.dart';
import 'package:amazon_fake/pages/login_page.dart';
import 'package:amazon_fake/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: const HomePage(),
        initialRoute: db.isLogged() ? '/' : '/register',
        routes: {
          '/': (context) => const HomePage(),
          '/checkout': (context) => const CheckoutPage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xFFc3e703),
          fontFamily: 'Montserrat',
        ));
  }
}
