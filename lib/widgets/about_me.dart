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
    return Container(
      margin: EdgeInsets.only(top: isSmall ? 16 : 64, bottom: isSmall ? 32 : 0),
      height: isSmall ? 240 : 160,
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
                overflow: TextOverflow.visible,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}
