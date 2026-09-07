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
    text: 'https://www.google.com/',
  );

  int loadingProgress = 0;
  String? errorMessage;
  bool isRetrying = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                loadingProgress = progress;
                if (progress > 20) {
                  errorMessage = null;
                }
              });
            }
          },

          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                loadingProgress = 0;
                errorMessage = null;
              });
            }
          },

          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                loadingProgress = 100;
              });
            }
          },

          onWebResourceError: (error) {
            if (!mounted) return;

            // Main frame-এর error হলে শুধু error দেখাব।
            if (error.isForMainFrame ?? true) {
              setState(() {
                errorMessage =
                    '${error.errorCode}: ${error.description}';
              });
            }
          },

          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://www.google.com/'),
      );
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  Future<void> openWebsite() async {
    String url = urlController.text.trim();

    if (url.isEmpty) return;

    if (!url.startsWith('http://') &&
        !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final uri = Uri.tryParse(url);

    if (uri == null || uri.host.isEmpty) {
      setState(() {
        errorMessage = 'সঠিক ওয়েবসাইট ঠিকানা দিন।';
      });
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      errorMessage = null;
      loadingProgress = 0;
    });

    await controller.loadRequest(uri);
  }

  Future<void> reloadPage() async {
    setState(() {
      errorMessage = null;
      loadingProgress = 0;
      isRetrying = true;
    });

    try {
      await controller.reload();
    } finally {
      if (mounted) {
        setState(() {
          isRetrying = false;
        });
      }
    }
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
          centerTitle: true,
          title: const Text(
            'ব্রাউজার',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: isRetrying ? null : reloadPage,
              icon: const Icon(Icons.refresh),
              tooltip: 'রিফ্রেশ',
            ),
          ],
        ),

        body: Column(
          children: [
            // URL Box
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                8,
              ),
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
                    Icons.language_rounded,
                  ),
                  suffixIcon: IconButton(
                    onPressed: openWebsite,
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                    ),
                  ),
                ),
              ),
            ),

            // Loading bar
            if (loadingProgress > 0 &&
                loadingProgress < 100)
              LinearProgressIndicator(
                value: loadingProgress / 100,
                minHeight: 2,
              ),

            // WebView
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(
                    controller: controller,
                  ),

                  // Error message
                  if (errorMessage != null)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.wifi_off_rounded,
                                size: 60,
                                color: Color(0xFF14532D),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'ওয়েব পেজ লোড করা যায়নি',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: reloadPage,
                                icon: const Icon(
                                  Icons.refresh,
                                ),
                                label: const Text(
                                  'আবার চেষ্টা করুন',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
