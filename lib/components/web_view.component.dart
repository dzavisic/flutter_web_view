import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_view_private/components/navigation_controls.component.dart';
import 'package:flutter_web_view_private/components/web_view_menu.component.dart';
import 'package:flutter_web_view_private/shared/utils/storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  const WebViewComponent({Key? key, required this.webViewController, required this.storageUtil, required this.jsNotifier}) : super(key: key);

  final Completer<WebViewController> webViewController;
  final StorageUtil storageUtil;
  final ValueNotifier<String> jsNotifier;

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
        actions: [
          NavigationControlsComponent(controller: widget.webViewController),
          WebViewMenuComponent(controller: widget.webViewController),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            onWebViewCreated: (webViewController) {
              widget.webViewController.complete(webViewController);
              widget.webViewController.future.then((webViewController) async {
                widget.storageUtil.readHtmlFile().then((html) {
                  webViewController.loadHtmlString(html);
                });
                webViewController.runJavascript(widget.jsNotifier.value);
              });
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            navigationDelegate: (navigation) {
              return NavigationDecision.navigate;
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: _createJavascriptChannels(context),
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      )
    );
  }

  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }
}