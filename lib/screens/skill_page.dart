import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_villains/villain.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:portfolio/widgets/responsive.dart';

import '../models/logo.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final LogoModel logo;

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child:
              // Villain(
              //   villainAnimation: VillainAnimation.fromBottom(
              //     from: const Duration(milliseconds: 300),
              //     to: const Duration(milliseconds: 600),
              //   ),
              //   child:
              FractionallySizedBox(
            heightFactor: 0.75,
            child: Transform.translate(
              offset: Offset(0, 40),
              // padding: const EdgeInsets.all(32.0),
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
                    widthFactor: isSmall ? null : 0.6,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SelectableText(
                          lorem(
                              paragraphs: 10, words: 5000), //logo.description,
                          style: GoogleFonts.notoSans(
                            fontSize: 18,
                            // color: antiFlashColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ),
        ),
        Align(
          alignment: const Alignment(0, -0.8),
          child: FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 0.6,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor.withOpacity(.75),
                  borderRadius: BorderRadius.circular(20)),
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
                  ),
                  SizedBox.square(dimension: 20),
                  Expanded(
                    child: SelectableText(
                      logo.description.tr(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1!
                          .apply(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
