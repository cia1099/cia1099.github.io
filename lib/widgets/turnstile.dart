import 'dart:ui_web';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class TurnStileHtmlView extends StatelessWidget {
  final void Function(String token)? tokenFeedback;
  TurnStileHtmlView({super.key, this.tokenFeedback}) {
    platformViewRegistry.registerViewFactory(
      'turnstile-view',
      (int viewId) => html.IFrameElement()
        ..src = '../turnstile.html' //default will concatenate web/
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
    // addTurnstileHtml();
    // registerTurnstileViewFactory();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for messages from the iframe
    html.window.onMessage.listen((event) {
      // print('what is turnstile? ${event.data}');
      tokenFeedback?.call(event.data);
    });
    return Container(
      // color: Colors.blue,
      width: 310,
      height: 75,
      child: HtmlElementView(viewType: 'turnstile-view'),
    );
  }

  void addTurnstileHtml() {
    final turnstileScript = html.ScriptElement()
      ..src = 'https://challenges.cloudflare.com/turnstile/v0/api.js'
      ..async = true
      ..defer = true;

    final turnstileDiv = html.DivElement()
      ..id = 'cf-turnstile'
      ..attributes = {
        'data-sitekey': '0x4AAAAAAAf8TH8pzrBHQzOS',
      };

    html.document.head!.append(turnstileScript);
    html.document.body!.append(turnstileDiv);
  }

  void registerTurnstileViewFactory() {
    // Register the HTML element view factory
    platformViewRegistry.registerViewFactory(
      'turnstile-view',
      (int viewId) {
        return html.DivElement()
          ..id = 'turnstile-html-container'
          ..style.width = '100%'
          ..style.height = '100%'
          ..children.add(html.DivElement()..id = 'cf-turnstile');
      },
    );
  }
}
