import 'package:flutter/material.dart';
import 'package:flutter_web_view_private/components/editors_card.component.dart';
import 'package:flutter_web_view_private/components/url_card.component.dart';
import 'package:flutter_web_view_private/shared/interfaces/orientation.interface.dart';
import 'package:flutter_web_view_private/shared/utils/storage.dart';
import 'package:flutter_web_view_private/shared/widgets/spacing.widget.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {

  String htmlTemplate = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Flutter Html Page</title>
</head>
<body>
  <h1 id="hello">Hello World</h1>
  <p>This is a paragraph</p>
  <button onclick="callAlert('Hello World')">Click Me</button>
</body>
</html>
''';
  String cssTemplate = '''
  #hello {
    color: red;
  }
''';

  StorageUtil storageUtil = StorageUtil();

  ValueNotifier<String> urlNotifier = ValueNotifier<String>('');
  TextEditingController urlController = TextEditingController();
  ValueNotifier<String> htmlNotifier = ValueNotifier<String>('');
  TextEditingController htmlController = TextEditingController();
  ValueNotifier<String> cssNotifier = ValueNotifier<String>('');
  TextEditingController cssController = TextEditingController();
  ValueNotifier<String> jsNotifier = ValueNotifier<String>('');
  TextEditingController jsController = TextEditingController();
  ValueNotifier<String> customJsNotifier = ValueNotifier<String>('');
  TextEditingController customJsController = TextEditingController();
  OrientationType orientationType = OrientationType();
  ValueNotifier<bool> expectResultNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    /// Set initial notifiers and controllers values
    htmlNotifier.value = htmlTemplate;
    htmlController.text = htmlTemplate;

    cssNotifier.value = cssTemplate;
    cssController.text = cssTemplate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /// RUN WEB VIEW FROM URL
            urlCard(urlController, urlNotifier, jsController, jsNotifier, expectResultNotifier, context),
            sSpacing(orientationType.Vertical),
            /// HTML, CSS and JS editors
            editorsCard(
              htmlController,
              htmlNotifier,
              cssController,
              cssNotifier,
              customJsController,
              customJsNotifier,
              context
            ),
          ],
        ),
      ),
    );
  }
}