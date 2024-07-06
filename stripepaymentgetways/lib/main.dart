import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripepaymentgetways/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51PZeTeKgHdApV8pzig96yzos5NS0VXN0fl2JXOFi16x6cN8THkOiwas6HScVzMZrRAcy4Vht7F1P7mjY8MjGlVbR00gy77yTzB';

  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
