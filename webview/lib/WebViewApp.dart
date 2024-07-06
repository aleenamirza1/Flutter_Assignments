import 'package:flutter/material.dart';
import 'package:webview/my_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse('https://google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    messenger.showSnackBar(
                        SnackBar(content: Text("No Back History Found")));
                    return;
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    messenger.showSnackBar(
                        SnackBar(content: Text("No Forward History Found")));
                    return;
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: () async {
                  controller.reload();
                },
              )
            ],
          )
        ],
      ),
      body: MyWebView(controller: controller),
    );
  }
}
