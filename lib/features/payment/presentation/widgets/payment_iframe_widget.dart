import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentIframeWidget extends StatefulWidget {
  final String iframeUrl;
  final Function() onPaymentSuccess;
  final Function(String) onPaymentFailed;

  const PaymentIframeWidget({
    super.key,
    required this.iframeUrl,
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
  });

  @override
  State<PaymentIframeWidget> createState() => _PaymentIframeWidgetState();
}

class _PaymentIframeWidgetState extends State<PaymentIframeWidget> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar progress
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            // Check if payment was successful or failed based on URL
            _handlePaymentResult(url);
          },
          onWebResourceError: (WebResourceError error) {
            widget.onPaymentFailed('Payment failed: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.iframeUrl));
  }

  void _handlePaymentResult(String url) {
    // You should adjust these URL patterns based on your payment gateway's success/failure URLs
    if (url.contains('success') || url.contains('payment_successful')) {
      widget.onPaymentSuccess();
    } else if (url.contains('failed') ||
        url.contains('error') ||
        url.contains('cancelled')) {
      widget.onPaymentFailed('Payment was cancelled or failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
