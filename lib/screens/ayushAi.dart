import 'package:ayurvan/widgets/ayush_ai_splash.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AyushAiScreen extends StatefulWidget {
  const AyushAiScreen({super.key});

  @override
  _AyushAiScreenState createState() => _AyushAiScreenState();
}

class _AyushAiScreenState extends State<AyushAiScreen> {
  late final WebViewController _controller; // WebView controller to manage navigation
  bool _isLoading = true; // Flag to control splash screen visibility

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://cdn.botpress.cloud/webchat/v2/shareable.html?botId=e075794e-a8eb-4d9c-ae72-fe709cee7f17')) // Load the URL
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript if needed
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; // Hide splash screen when the page finishes loading
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller), // Updated WebView widget
          if (_isLoading)
            const Center(
              child: AyushAiSplash(), // Splash screen while loading
            ),
        ],
      ),
    );
  }
}
