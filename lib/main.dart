import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      home: KioskContainer(),
      debugShowCheckedModeBanner: false,
    ));

class KioskContainer extends StatefulWidget {
  @override
  _KioskContainerState createState() => _KioskContainerState();
}

class _KioskContainerState extends State<KioskContainer>
    with AfterLayoutMixin<KioskContainer> {
  String url = "https://www.example.com/";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl("https://www.google.com");
            _controller.complete(webViewController);
          },
          backgroundColor: const Color(0x00000000),
        );
      }),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}
