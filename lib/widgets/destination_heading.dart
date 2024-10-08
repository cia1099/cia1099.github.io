import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:flutter/material.dart';

class DestinationHeading extends StatelessWidget {
  const DestinationHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            // color: Colors.red,
            padding: EdgeInsets.only(
              // top: screenSize.height / 30,
              bottom: screenSize.height / 30,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: Text(
              'portfolio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          )
        : Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 10,
              // bottom: screenSize.height / 15,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: Text(
              'portfolio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          );
  }
}
