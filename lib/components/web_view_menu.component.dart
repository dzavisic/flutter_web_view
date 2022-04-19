import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegateAndRunJavaScript,
}

class WebViewMenuComponent extends StatelessWidget {
  const WebViewMenuComponent({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, controller) {
        return PopupMenuButton<_MenuOptions>(
          onSelected: (value) async {
            switch (value) {
              case _MenuOptions.navigationDelegateAndRunJavaScript:
                controller.data!.loadUrl('https://jaspero.co');
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.navigationDelegateAndRunJavaScript,
              child: Text('Navigate to Jaspero'),
            ),
          ],
        );
      },
    );
  }
}