import 'package:booking/presentation/presentation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String? url;
  final String? html;
  const WebView({super.key, this.url, this.html});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    if (widget.url != null) {
      controller.loadRequest(Uri.parse(widget.url!));
    } else if (widget.html != null) {
      controller.loadHtmlString(widget.html!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
