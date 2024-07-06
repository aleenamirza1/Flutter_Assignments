import 'package:flutter/material.dart';
import 'package:qrcodescanning/qrScanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0)),
      home: QrScanner(),
      debugShowCheckedModeBanner: false,
      title: "QR Scanner",
    );
  }
}
