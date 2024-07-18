import 'dart:math';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:portfolio/widgets/explore_drawer.dart';

import '../widgets/responsive.dart';
import '../widgets/top_bar_contents.dart';

class ExperiencePage extends StatelessWidget {
  ExperiencePage({super.key});
  double _scrollPosition = 0;
  double _opacity = 0;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.position.pixels;
      _opacity = _scrollPosition < screenSize.height * 0.40
          ? _scrollPosition / (screenSize.height * 0.40)
          : 1;
    });
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    final contentWidth = (screenSize.width - 200 - 2 * screenSize.width / 15)
        .clamp(500.0, double.infinity);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      // drawer: ExploreDrawer(),
      appBar: isSmall
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Text(
                'profile',
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ).tr(),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    return TopBarContents(_opacity);
                  }),
            ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).bottomAppBarColor,
            height: kToolbarHeight,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: kToolbarHeight,
                left: screenSize.width / 15,
                right: screenSize.width / 15),
            controller: _scrollController,
            child: Column(
              children: [
                Text(lorem(paragraphs: 1, words: 20)),
                ...List.generate(
                  20,
                  (i) => Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Container(
                            width: contentWidth,
                            color: Colors.blue,
                            child: Text(
                              lorem(paragraphs: 1, words: 1),
                              style:
                                  Theme.of(context).primaryTextTheme.headline2,
                            )),
                        Container(
                            width: 200,
                            color: Colors.red,
                            child: Text(
                              lorem(paragraphs: 1, words: 1),
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                            )),
                        Container(
                          width: contentWidth + 200,
                          child: Flex(
                              direction:
                                  isSmall ? Axis.vertical : Axis.horizontal,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(right: 10),
                                  color: Colors.green,
                                ),
                                Container(
                                  width:
                                      contentWidth + 200 - (isSmall ? 0 : 110),
                                  child: Text(
                                    lorem(paragraphs: 1, words: 200),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle1,
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
