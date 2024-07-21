import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:http/http.dart' as http;

class HtmlPage extends StatelessWidget {
  final String url;
  final String path;
  final Map<String, dynamic>? queryArgs;
  const HtmlPage(
      {super.key, required this.url, this.queryArgs, required this.path});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(url);
    final request = Uri(
        scheme: uri.scheme,
        host: uri.host,
        port: uri.port,
        path: path,
        queryParameters: queryArgs);
    return Scaffold(
        body: InAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri.uri(request), mainDocumentURL: WebUri.uri(uri)),
    )
        //     FutureBuilder(
        //   future: http.get(request),
        //   builder: (context, snapshot) {
        //     if (snapshot.data == null)
        //       return CircularProgressIndicator.adaptive();
        //     final header = snapshot.data!.headers;
        //     final contentType = header['content-type']!;
        //     return InAppWebView(
        //       initialData: InAppWebViewInitialData(
        //           data: snapshot.data!.body,
        //           mimeType: contentType.split(';')[0].trim(),
        //           encoding: contentType.substring(contentType.lastIndexOf('utf')),
        //           baseUrl: WebUri.uri(uri),
        //           historyUrl: WebUri.uri(uri)),
        //     );
        //   },
        // ),
        );
  }
}
