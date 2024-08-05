import 'dart:math';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/global_data.dart';
import 'package:portfolio/widgets/bottom_bar.dart';
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
    final experienceColumnKey = GlobalKey();
    // for main scaffold
    double _scrollPosition = 0;
    final _scrollController = ScrollController();
    final screenSize = MediaQuery.of(context).size;
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.position.pixels;
      _opacity = _scrollPosition < screenSize.height * 0.40
          ? _scrollPosition / (screenSize.height * 0.40)
          : 1;
    });
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    double? leftSideHeight;

    return Scaffold(
      key: scaffoldKey,
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
        backgroundColor: Theme.of(context).colorScheme.background,
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
              ),
              controller: _scrollController,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenSize.width / 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Offstage(
                          offstage: isSmall,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) => setState(() {
                                  final renderBox = experienceColumnKey
                                      .currentContext
                                      ?.findRenderObject() as RenderBox;
                                  leftSideHeight = renderBox.size.height;
                                }),
                              );
                              return Container(
                                margin: EdgeInsets.only(right: 32),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1,
                                            color: Color(0x8ACBC6D1)))),
                                padding: EdgeInsets.only(top: 16),
                                width: 200,
                                height: leftSideHeight,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HighlineText(
                                          '${"core_technologies".tr()}:'),
                                      SelectableText(
                                          coreTechnologies
                                              .map((e) =>
                                                  String.fromCharCode(9635) +
                                                  ' $e')
                                              .join('\n'),
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2
                                              ?.apply(heightDelta: 0.8)),
                                      HighlineText(
                                          '${'kernel_competence'.tr()}:'),
                                      SelectableText(
                                        kernelCompetence
                                            .map((e) =>
                                                String.fromCharCode(9635) +
                                                ' $e')
                                            .join('\n'),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2
                                            ?.apply(heightDelta: 0.8),
                                      ),
                                      if (leftSideHeight != null)
                                        ...[
                                              const Expanded(child: SizedBox()),
                                              HighlineText(
                                                  '${'education'.tr()}:'),
                                            ] +
                                            degreeEdu
                                                .map((e) => SelectableText.rich(
                                                    TextSpan(children: [
                                                      const WidgetSpan(
                                                          child: Icon(
                                                        Icons.school_sharp,
                                                        size: 16,
                                                      )),
                                                      TextSpan(
                                                          text:
                                                              '${'$e.degree'.tr()}@${'$e.subject'.tr()}'),
                                                      TextSpan(
                                                          text:
                                                              '\n${'$e.school'.tr()}',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .subtitle2),
                                                    ]),
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .button))
                                                .toList(),
                                    ]),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: ExperienceColumn(
                              key: experienceColumnKey,
                              screenSize: screenSize,
                              isSmall: isSmall),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(30),
                  //   width: double.maxFinite,
                  //   color: Theme.of(context).bottomAppBarColor,
                  //   child: Text(
                  //     'Copyright © 2024 | Otto Lin',
                  //     style: TextStyle(
                  //       color: Colors.blueGrey[300],
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  // ),
                  BottomBar()
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

class HighlineText extends StatelessWidget {
  final String text;
  const HighlineText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.transparent,
          Colors.yellow.shade400,
          Colors.yellow.shade50,
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [.6, .61, .85, .86],
      )),
      child: SelectableText(text,
          style: Theme.of(context).primaryTextTheme.subtitle1),
    );
  }
}

class ExperienceColumn extends StatelessWidget {
  const ExperienceColumn({
    super.key,
    required this.screenSize,
    required this.isSmall,
  });

  final Size screenSize;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    const experiences = ['bobi', 'patere', 'foxconn', 'lips'];
    const expMapImg = {1: '3dGaze.webp', 3: 'people_counting.png'};
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Otto Lin",
                style: GoogleFonts.electrolize(
                  letterSpacing: 2,
                  fontSize: screenSize.width / 8,
                  color: Theme.of(context).primaryTextTheme.headline2!.color,
                ),
              ),
              Text(
                "Expert Flutter Developer and Vision Algorithm Engineer",
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              if (isSmall) ...[
                Text.rich(TextSpan(
                    text: String.fromCharCode(9635),
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                    children: [
                      WidgetSpan(
                          child: HighlineText(' ${'core_technologies'.tr()}:')),
                    ])),
                SelectableText(coreTechnologies.join(', '),
                    style: Theme.of(context).primaryTextTheme.subtitle2),
                Text.rich(TextSpan(
                    text: String.fromCharCode(9635),
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                    children: [
                      WidgetSpan(
                          child: HighlineText(' ${'kernel_competence'.tr()}:')),
                    ])),
                SelectableText(kernelCompetence.join(', '),
                    style: Theme.of(context).primaryTextTheme.subtitle2)
              ]
            ],
          ),
          Transform.translate(
            offset: Offset(0, 32),
            child: Container(
              child: SelectableText('introduce.advantage'.tr(),
                  style: Theme.of(context).primaryTextTheme.subtitle1),
            ),
          ),
          Divider(height: 32),
          ...List.generate(
            experiences.length,
            (i) {
              final previewWidth = expMapImg.containsKey(i)
                  ? isSmall
                      ? constraints.maxWidth
                      : 160.0
                  : .0;
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Container(
                        // color: Colors.blue,
                        child: SelectableText.rich(
                      TextSpan(text: '${experiences[i]}.name'.tr(), children: [
                        WidgetSpan(child: Icon(CupertinoIcons.minus)),
                        TextSpan(
                            text: '${experiences[i]}.title'.tr(),
                            style: Theme.of(context).primaryTextTheme.button)
                      ]),
                      style: Theme.of(context).primaryTextTheme.headline2,
                    )),
                    Container(
                        width: 150,
                        // color: Colors.red,
                        child: SelectableText.rich(
                          TextSpan(
                            // text: "${experiences[i]}.address".tr() + "\n",
                            children: [
                              TextSpan(
                                  text: DateFormat.yMMM().format(
                                      DateFormat("d/M/yyyy").parse(
                                          '${experiences[i]}.start'.tr()))),
                              TextSpan(text: " ~ "),
                              TextSpan(
                                  text: DateFormat.yMMM().format(
                                      DateFormat('d/M/yyyy').parse(
                                          '${experiences[i]}.end'.tr()))),
                            ],
                          ),
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        )),
                    Container(
                      // color: Colors.green,
                      margin: EdgeInsets.only(top: 10),
                      width: constraints.maxWidth,
                      child: Flex(
                          direction: isSmall ? Axis.vertical : Axis.horizontal,
                          children: [
                            if (expMapImg.containsKey(i))
                              MediaPreview(
                                previewWidth: previewWidth,
                                assetName: expMapImg[i]!,
                                embeddingPlayer: isSmall,
                              ),
                            Container(
                              width: constraints.maxWidth -
                                  previewWidth * (isSmall ? 0 : 1),
                              child: SelectableText(
                                '${experiences[i]}.content'.tr(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1,
                                // textAlign: TextAlign.justify,
                              ),
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
    );
  }
}

class MediaPreview extends StatefulWidget {
  const MediaPreview({
    super.key,
    required this.previewWidth,
    required this.assetName,
    this.embeddingPlayer = false,
  });

  final double previewWidth;
  final String assetName;
  final bool embeddingPlayer;

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  var isHover = false, isPlayer = false;
  @override
  Widget build(BuildContext context) {
    final width = widget.previewWidth - 10;
    final height = widget.previewWidth < 180 ? width * .8 : width / 2;
    return isPlayer
        ? Container(
            width: width,
            height: height,
            child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri.uri(getUri()))),
          )
        : Container(
            margin: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: widget.embeddingPlayer
                  ? () => setState(() {
                        isPlayer = true;
                      })
                  : playVideo,
              onHover: (value) => setState(() {
                isHover = value;
              }),
              child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/${widget.assetName}'))),
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
    final url = getUri();
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Uri getUri() {
    final baseName = p.basenameWithoutExtension(widget.assetName);
    return Uri.parse(
        MyApp.monitorUrl + '/profile/media?filename=$baseName.mp4');
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
