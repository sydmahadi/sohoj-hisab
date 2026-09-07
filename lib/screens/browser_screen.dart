import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late final WebViewController controller;

  final TextEditingController urlController =
      TextEditingController(
    text: 'https://www.google.com',
  );

  bool isLoading = true;
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (!mounted) return;

            setState(() {
              isLoading = true;
              loadingProgress = 0;
              urlController.text = url;
            });
          },

          onProgress: (int progress) {
            if (!mounted) return;

            setState(() {
              loadingProgress = progress;
            });
          },

          onPageFinished: (String url) {
            if (!mounted) return;

            setState(() {
              isLoading = false;
              loadingProgress = 100;
              urlController.text = url;
            });
          },

          onWebResourceError: (WebResourceError error) {
            if (!mounted) return;

            setState(() {
              isLoading = false;
            });
          },
        ),
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

  Future<void> handleBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    } else {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        handleBack();
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('ব্রাউজার'),

          actions: [
            IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.refresh),
              tooltip: 'রিফ্রেশ',
            ),
          ],
        ),

        body: Column(
          children: [

            // =========================
            // URL Bar
            // =========================
            Padding(
              padding: const EdgeInsets.all(10),

              child: TextField(
                controller: urlController,

                keyboardType: TextInputType.url,

                textInputAction: TextInputAction.go,

                onSubmitted: (_) {
                  openWebsite();
                },

                decoration: InputDecoration(
                  hintText: 'ওয়েবসাইট লিখুন',

                  prefixIcon: const Icon(
                    Icons.language,
                  ),

                  suffixIcon: IconButton(
                    onPressed: openWebsite,
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                  ),
                ),
              ),
            ),

            // =========================
            // Loading Progress
            // =========================
            if (isLoading)
              LinearProgressIndicator(
                value: loadingProgress > 0
                    ? loadingProgress / 100
                    : null,
              ),

            // =========================
            // WebView
            // =========================
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
