import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() =>
      _BrowserScreenState();
}

class _BrowserScreenState
    extends State<BrowserScreen> {

  late final WebViewController controller;

  final TextEditingController urlController =
      TextEditingController(
    text: 'https://www.google.com',
  );

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..loadRequest(
        Uri.parse('https://www.google.com'),
      );
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  void openWebsite() {
    String url = urlController.text.trim();

    if (url.isEmpty) return;

    if (!url.startsWith('http://') &&
        !url.startsWith('https://')) {
      url = 'https://$url';
    }

    controller.loadRequest(
      Uri.parse(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ব্রাউজার'),

        actions: [
          IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: urlController,

                    keyboardType:
                        TextInputType.url,

                    textInputAction:
                        TextInputAction.go,

                    onSubmitted: (_) {
                      openWebsite();
                    },

                    decoration: InputDecoration(
                      hintText: 'ওয়েবসাইট লিখুন',
                      prefixIcon:
                          const Icon(Icons.language),

                      suffixIcon: IconButton(
                        onPressed: openWebsite,
                        icon: const Icon(
                          Icons.arrow_forward,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
