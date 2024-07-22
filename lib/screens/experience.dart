import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/widgets/explore_drawer.dart';
import 'package:portfolio/widgets/language_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/responsive.dart';
import '../widgets/top_bar_contents.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    // for app bar
    double _opacity = 0;
    var isHover = false;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final innerScaffoldKey = GlobalKey<ScaffoldState>();
    // for main scaffold
    double _scrollPosition = 0;
    final _scrollController = ScrollController();
    const experiences = ['bobi', 'patere', 'foxconn', 'lips'];
    final expMapImg = {1: '3dGaze.webp', 3: 'people_counting.png'};
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
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      drawer: ExploreDrawer(innerScaffoldKey: innerScaffoldKey),
      appBar: isSmall
          ? generateAppBar(
              context, _opacity, isHover, scaffoldKey, innerScaffoldKey)
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    return TopBarContents(_opacity);
                  }),
            ),
      body: Scaffold(
        key: innerScaffoldKey,
        drawer: const LanguageDrawer(),
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
                    experiences.length,
                    (i) {
                      final previewWidth = expMapImg.containsKey(i)
                          ? isSmall
                              ? screenSize.width * 0.8
                              : 160.0
                          : .0;
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Container(
                                width: contentWidth,
                                // color: Colors.blue,
                                child: Text.rich(
                                  TextSpan(
                                      text: '${experiences[i]}.name'.tr(),
                                      children: [
                                        WidgetSpan(
                                            child: Icon(CupertinoIcons.minus)),
                                        TextSpan(
                                            text:
                                                '${experiences[i]}.title'.tr(),
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .button)
                                      ]),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline2,
                                )),
                            Container(
                                width: 150,
                                // color: Colors.red,
                                child: Text.rich(
                                  TextSpan(
                                    // text: "${experiences[i]}.address".tr() + "\n",
                                    children: [
                                      TextSpan(
                                          text: DateFormat.yMMM().format(
                                              DateFormat("d/M/yyyy").parse(
                                                  '${experiences[i]}.start'
                                                      .tr()))),
                                      TextSpan(text: " ~ "),
                                      TextSpan(
                                          text: DateFormat.yMMM().format(
                                              DateFormat('d/M/yyyy').parse(
                                                  '${experiences[i]}.end'
                                                      .tr()))),
                                    ],
                                  ),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                )),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: contentWidth + 200,
                              child: Flex(
                                  direction:
                                      isSmall ? Axis.vertical : Axis.horizontal,
                                  children: [
                                    if (expMapImg.containsKey(i))
                                      MediaPreview(
                                          previewWidth: previewWidth,
                                          assetName: expMapImg[i]!),
                                    Container(
                                      width: contentWidth +
                                          150 -
                                          (isSmall ? 0 : previewWidth),
                                      child: Text(
                                        '${experiences[i]}.content',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1,
                                        // textAlign: TextAlign.justify,
                                      ).tr(),
                                    )
                                  ]),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar generateAppBar(
      BuildContext context,
      double opacity,
      bool isHover,
      GlobalKey<ScaffoldState> scaffoldKey,
      GlobalKey<ScaffoldState> innerScaffoldKey) {
    return AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor.withOpacity(opacity),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          if (innerScaffoldKey.currentState!.isDrawerOpen) {
            innerScaffoldKey.currentState?.closeDrawer();
          }
          scaffoldKey.currentState?.openDrawer();
        },
      ),
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
      title: StatefulBuilder(
        builder: (context, setState) => InkWell(
          onHover: (value) => setState(() => isHover = value),
          onTap: () =>
              Navigator.of(context).popUntil(ModalRoute.withName(MyApp.home)),
          hoverColor: Colors.transparent,
          child: Text(
            'profile',
            style: TextStyle(
              color: isHover ? Colors.blue[200] : Colors.blueGrey.shade100,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ).tr(),
        ),
      ),
    );
  }
}

class MediaPreview extends StatefulWidget {
  const MediaPreview({
    super.key,
    required this.previewWidth,
    required this.assetName,
  });

  final double previewWidth;
  final String assetName;

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  var isHover = false;
  @override
  Widget build(BuildContext context) {
    final width = widget.previewWidth - 10;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: playVideo,
        onHover: (value) => setState(() {
          isHover = value;
        }),
        child: Container(
            height: widget.previewWidth < 180 ? width * .8 : width / 2,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${widget.assetName}'))),
            child: isHover
                ? Icon(
                    CupertinoIcons.play_circle,
                    size: width / (widget.previewWidth < 180 ? 2 : 4),
                  )
                : null),
      ),
    );
  }

  void playVideo() async {
    final baseName = p.basenameWithoutExtension(widget.assetName);
    final url =
        Uri.parse(MyApp.monitorUrl + '/profile/media?filename=$baseName.mp4');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
