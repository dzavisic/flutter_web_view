import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_view_private/components/web_view.component.dart';
import 'package:flutter_web_view_private/shared/interfaces/orientation.interface.dart';
import 'package:flutter_web_view_private/shared/utils/storage.dart';
import 'package:flutter_web_view_private/shared/widgets/spacing.widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

OrientationType orientationType = OrientationType();
StorageUtil storageUtil = StorageUtil();

Widget editorsCard(
    TextEditingController htmlController,
    ValueNotifier<String> htmlNotifier,
    TextEditingController cssController,
    ValueNotifier<String> cssNotifier,
    TextEditingController jsController,
    ValueNotifier<String> jsNotifier,
    BuildContext context,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            cardTitle(),
            xsSpacing(orientationType.Vertical),
            title('HTML'),
            xsSpacing(orientationType.Vertical),
            htmlInputBox(htmlController, htmlNotifier),
            sSpacing(orientationType.Vertical),
            title('CSS'),
            xsSpacing(orientationType.Vertical),
            cssInputBox(cssController, cssNotifier),
            sSpacing(orientationType.Vertical),
            title('JS'),
            xsSpacing(orientationType.Vertical),
            jsInputBox(jsController, jsNotifier),
            xsSpacing(orientationType.Vertical),
            runButton(htmlNotifier, cssNotifier, jsNotifier, context),
          ],
        ),
      ),
    ),
  );
}

Widget cardTitle() {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: const Text(
      'HTML & CSS & JS Card',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget title(
  String title
  ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('$title CODE'),
    ],
  );
}

Widget htmlInputBox(
  TextEditingController htmlController,
  ValueNotifier<String> htmlNotifier
  ) {
  return TextField(
    controller: htmlController,
    onChanged: (value) {
      htmlNotifier.value = value;
    },
    maxLines: null,
    keyboardType: TextInputType.multiline,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget cssInputBox(
    TextEditingController cssController,
    ValueNotifier<String> cssNotifier
    ) {
  return TextField(
    controller: cssController,
    onChanged: (value) {
      cssNotifier.value = value;
    },
    maxLines: null,
    keyboardType: TextInputType.multiline,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget jsInputBox(
    TextEditingController jsController,
    ValueNotifier<String> jsNotifier
    ) {
  return TextField(
    controller: jsController,
    onChanged: (value) {
      jsNotifier.value = value;
    },
    maxLines: null,
    keyboardType: TextInputType.multiline,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget runButton(
    ValueNotifier<String> htmlNotifier,
    ValueNotifier<String> cssNotifier,
    ValueNotifier<String> jsNotifier,
    BuildContext context
    ) {
  return ElevatedButton(
    child: const Text('RUN'),
    onPressed: () {
      String newHtml = htmlNotifier.value.replaceAll('</head>', '<style>${cssNotifier.value}</style></head>');
      storageUtil.writeHtml(newHtml);

      Completer<WebViewController> webViewController = Completer<WebViewController>();
      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewComponent(webViewController: webViewController, type: 'editors', storageUtil: storageUtil, jsNotifier: jsNotifier, urlNotifier: ValueNotifier(''))));
    },
  );
}