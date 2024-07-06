import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    this.screenSize,
  }) : super(key: key);

  final Size? screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize!.height * 0.06,
        left: screenSize!.width / 15,
        right: screenSize!.width / 15,
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(),
                Text(
                  'skills',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                SizedBox(height: 5),
                Text(
                  'introduce.skill',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ).tr(),
                SizedBox(height: 10),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'skills',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                Expanded(
                  child: Text(
                    'introduce.skill',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ).tr(),
                ),
              ],
            ),
    );
  }
}
