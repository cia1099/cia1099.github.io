import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/roadmap_view.dart';

import '../models/logo.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final LogoModel logo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: .85,
            widthFactor: .95,
            child: Dialog(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 10,
                        offset: Offset(7, 7),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: FractionallySizedBox(
                  heightFactor: 0.8,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoadmapView(whichMap: logo.roadmapPath),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.8),
          child: FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 0.6,
            child: Row(
              children: [
                Hero(
                    tag: logo.tag,
                    child: logo.assetPath.isEmpty
                        ? FlutterLogo(size: 100)
                        : Image.asset(
                            logo.assetPath,
                            width: 125,
                            height: 125,
                            fit: BoxFit.fitHeight,
                          ),
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      final rot = CurvedAnimation(
                          parent: animation, curve: Curves.ease);
                      return AnimatedBuilder(
                          animation: rot,
                          builder: (context, child) {
                            final rotTween = Tween(begin: .0, end: 4 * pi);
                            return Transform(
                                alignment: Alignment.center,
                                transform:
                                    Matrix4.rotationY(rotTween.evaluate(rot)),
                                child: child);
                          },
                          child: toHeroContext.widget);
                    }),
                SizedBox.square(dimension: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(.75),
                        borderRadius: BorderRadius.circular(20)),
                    child: SelectableText(
                      logo.description.tr(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1!
                          .apply(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
