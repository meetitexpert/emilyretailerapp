// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../Utils/ColorTools.dart';

class webViewScreen extends StatefulWidget {
  final String url;
  final String title;
  const webViewScreen({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<webViewScreen> createState() => _webViewScreenState();
}

class _webViewScreenState extends State<webViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: ProgressHUD(
            backgroundColor: Color(ColorTools.primaryColor),
            backgroundRadius: Radius.circular(8),
            padding: EdgeInsets.all(24),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Roboto-Regular",
                decoration: TextDecoration.none),
            child: Builder(
                builder: (context) => InAppWebView(
                      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                      onLoadStart:
                          (InAppWebViewController controller, Uri? url) {
                        final progress = ProgressHUD.of(context);
                        progress?.showWithText("Loading...");
                      },
                      onLoadStop:
                          (InAppWebViewController controller, Uri? url) {
                        final progress = ProgressHUD.of(context);
                        progress?.dismiss();
                      },
                      onLoadError: (InAppWebViewController controller, Uri? url,
                          int code, String message) {
                        final progress = ProgressHUD.of(context);
                        progress?.dismiss();
                      },
                    ))));
  }
}
