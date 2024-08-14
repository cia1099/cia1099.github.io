import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/responsive.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth / (isSmall ? 1 : 4 / 3) -
        (isSmall ? screenWidth / 15 * 4 : 0);
    final textStyle = Theme.of(context).primaryTextTheme.subtitle1!;
    final textHeight = "introduce.detail"
        .tr()
        .calculateTextHeight(maxWidth: textWidth, style: textStyle);
    return Container(
      // color: Colors.green,
      margin: EdgeInsets.only(top: isSmall ? 16 : 64),
      height: textHeight,
      padding:
          isSmall ? EdgeInsets.symmetric(horizontal: screenWidth / 15) : null,
      child: Flex(
        direction: isSmall ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: isSmall ? null : Alignment.center,
              decoration: isSmall
                  ? null
                  : BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(right: BorderSide(color: Colors.grey))),
              child: Text(
                "about_me",
                style: TextStyle(
                    fontSize: isSmall ? 24 : 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: isSmall ? null : Alignment.bottomCenter,
              padding: isSmall
                  ? null
                  : EdgeInsets.only(left: 4, right: screenWidth / 15),
              child: Text(
                "introduce.detail",
                // textAlign: TextAlign.justify,
                // overflow: TextOverflow.visible,
                style: textStyle,
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}

extension Profile on String {
  double calculateTextHeight({
    required double maxWidth,
    required TextStyle style,
    int maxLines = 2 ^ 31 - 1,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: ui.TextDirection.ltr,
      // textAlign: TextAlign.,
      maxLines: maxLines,
    )..layout(maxWidth: maxWidth);

    return textPainter.size.height;
  }
}
