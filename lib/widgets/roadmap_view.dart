import 'dart:ui_web';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class RoadmapView extends StatelessWidget {
  final String whichMap;
  RoadmapView({super.key, required this.whichMap}) {
    platformViewRegistry.registerViewFactory(
      '$whichMap-view',
      (int viewId) => html.IFrameElement()
        ..src = '../$whichMap' //default will concatenate web/
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: HtmlElementView(viewType: '$whichMap-view')),
    );
  }
}
