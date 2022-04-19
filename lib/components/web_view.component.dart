import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_view_private/components/navigation_controls.component.dart';
import 'package:flutter_web_view_private/components/web_view_menu.component.dart';
import 'package:flutter_web_view_private/shared/utils/storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  const WebViewComponent({Key? key, required this.webViewController, required this.storageUtil, required this.type, required this.jsNotifier, required this.urlNotifier}) : super(key: key);

  final Completer<WebViewController> webViewController;
  final StorageUtil storageUtil;
  final ValueNotifier<String> jsNotifier;
  final String type;
  final ValueNotifier<String> urlNotifier;

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
            initialUrl: widget.type == 'url' ? widget.urlNotifier.value : null,
            onWebViewCreated: (webViewController) {
              widget.webViewController.complete(webViewController);
              if (widget.type == 'editors') {
                widget.webViewController.future.then((webViewController) async {
                  widget.storageUtil.readHtmlFile().then((html) {
                    webViewController.loadHtmlString(html);
                  });
                });
              }
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
              if (widget.jsNotifier.value.isNotEmpty) {
                widget.webViewController.future.then((webViewController) async {
                  webViewController.runJavascriptReturningResult(widget.jsNotifier.value).then((result) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Console output: $result', style: const TextStyle(fontFamily: 'monospace', fontSize: 15)),
                    ));
                  });
                });
              }
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