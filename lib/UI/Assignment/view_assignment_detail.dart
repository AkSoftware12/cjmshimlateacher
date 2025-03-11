import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the original PDF URL with Google Docs Viewer
    const String pdfUrl = 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';
    final String googleDocsUrl = 'https://docs.google.com/viewer?url=${Uri.encodeComponent(pdfUrl)}';

    return Scaffold(
      appBar: AppBar(title: const Text('WebView PDF Example')),
      body: WebView(
        initialUrl: googleDocsUrl, // Use Google Docs Viewer URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {
          print('Error: ${error.description}');
        },
      ),
    );
  }
}