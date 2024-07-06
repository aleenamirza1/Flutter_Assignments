import 'package:flutter/material.dart';
import 'package:webview/WebViewApp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Welcome", home: WebView());
  }
}
