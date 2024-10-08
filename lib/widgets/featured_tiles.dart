import 'package:portfolio/models/logo.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../screens/skill_page.dart';

class FeaturedTiles extends StatelessWidget {
  FeaturedTiles({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  final List<String> assets = [
    'assets/images/flutter-development.jpeg',
    'assets/images/ios.webp',
    'assets/images/python-fastapi.jpg',
    'assets/images/cv.gif',
    'assets/images/cpp.jpeg',
    'assets/images/git.png'
  ];

  final List<String> title = [
    'Flutter',
    'Swift',
    'Python',
    'Computer Vision',
    'C++',
    'Git Version Control'
  ];
  final logos = [
    LogoModel(
        tag: 'flutter',
        description: 'description.flutter',
        roadmapPath: 'roadmap_full_stack.html'),
    LogoModel(
        tag: 'swift',
        description: 'description.swift',
        assetPath: 'assets/images/logo_swift.png',
        roadmapPath: 'roadmap_full_stack.html'),
    LogoModel(
        tag: 'python',
        description: 'description.python',
        assetPath: 'assets/images/logo_python.png',
        roadmapPath: 'roadmap_full_stack.html'),
    LogoModel(
        tag: 'computer_vision',
        description: 'description.computer_vision',
        assetPath: 'assets/images/logo_cv.png',
        roadmapPath: 'roadmap_cv.html'),
    LogoModel(
        tag: 'cpp',
        description: 'description.cpp',
        assetPath: 'assets/images/logo_cpp.png',
        roadmapPath: 'roadmap_cv.html'),
    LogoModel(
        tag: 'git',
        description: 'description.git',
        assetPath: 'assets/images/logo_git.png',
        roadmapPath: 'roadmap_git.html')
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? narrowScreenLayout(context)
        : wideScreenLayout(context);
  }

  Widget wideScreenLayout(BuildContext context) {
    var hoverIndex = -1;
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 16,
        runSpacing: 32,
        children: [
          ...Iterable<int>.generate(assets.length).map(
            (int pageIndex) => Column(
              children: [
                StatefulBuilder(
                  builder: (context, setState) => AnimatedPhysicalModel(
                    duration: Durations.extralong4,
                    shape: BoxShape.rectangle,
                    elevation: hoverIndex == pageIndex ? 12 : 0,
                    color: Theme.of(context).backgroundColor,
                    shadowColor:
                        Theme.of(context).primaryTextTheme.headline2!.color!,
                    borderRadius: BorderRadius.circular(5),
                    curve: Curves.fastOutSlowIn,
                    child: ShaderMask(
                      shaderCallback: (bounds) => RadialGradient(
                              radius: .9,
                              colors: hoverIndex == pageIndex
                                  ? [
                                      Theme.of(context)
                                          .primaryTextTheme
                                          .headline2!
                                          .color!,
                                      Colors.black87
                                    ]
                                  : [Colors.white, Colors.white])
                          .createShader(bounds),
                      child: SizedBox(
                        height: screenSize.width / 6,
                        width: screenSize.width / 3.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: InkWell(
                            onHover: (value) => setState(
                                () => hoverIndex = value ? pageIndex : -1),
                            onTap: () =>
                                displayDialog(context, logos[pageIndex]),
                            child: Hero(
                                tag: logos[pageIndex].tag,
                                child: Image.asset(
                                  assets[pageIndex],
                                  fit: BoxFit.cover,
                                ),
                                placeholderBuilder:
                                    (context, heroSize, child) => ShaderMask(
                                          shaderCallback: (bounds) =>
                                              RadialGradient(
                                                  radius: .9,
                                                  colors: [
                                                Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2!
                                                    .color!,
                                                Colors.black87
                                              ]).createShader(bounds),
                                          child: child,
                                        )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height / 70,
                  ),
                  child: Text(
                    title[pageIndex],
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color:
                          Theme.of(context).primaryTextTheme.subtitle1!.color,
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

  void displayDialog(BuildContext context, LogoModel logo) {
    //ref. https://stackoverflow.com/questions/44403417/hero-animation-with-an-alertdialog
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) =>
          SkillPage(logo: logo),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacityTween = Tween<double>(begin: 0, end: 1).chain(
          CurveTween(curve: Curves.easeInQuart),
        );
        return FadeTransition(
          opacity: animation.drive(opacityTween),
          child: child,
        );
      },
    ));
  }

  Widget narrowScreenLayout(BuildContext context) {
    var hoverIndex = -1;
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height / 50),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: screenSize.width / 15),
            ...Iterable<int>.generate(assets.length).map(
              (int pageIndex) => Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) => AnimatedPhysicalModel(
                          duration: Durations.extralong4,
                          shape: BoxShape.rectangle,
                          elevation: hoverIndex == pageIndex ? 12 : 0,
                          color: Theme.of(context).backgroundColor,
                          shadowColor: Theme.of(context)
                              .primaryTextTheme
                              .headline2!
                              .color!,
                          borderRadius: BorderRadius.circular(5),
                          curve: Curves.fastOutSlowIn,
                          child: ShaderMask(
                            shaderCallback: (bounds) => RadialGradient(
                                    radius: .9,
                                    colors: hoverIndex == pageIndex
                                        ? [
                                            Theme.of(context)
                                                .primaryTextTheme
                                                .headline2!
                                                .color!,
                                            Colors.black87
                                          ]
                                        : [Colors.white, Colors.white])
                                .createShader(bounds),
                            child: SizedBox(
                              height: screenSize.width / 2.5,
                              width: screenSize.width / 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: InkWell(
                                  onHover: (value) => setState(() =>
                                      hoverIndex = value ? pageIndex : -1),
                                  onTap: () =>
                                      displayDialog(context, logos[pageIndex]),
                                  child: Hero(
                                      tag: logos[pageIndex].tag,
                                      child: Image.asset(
                                        assets[pageIndex],
                                        fit: BoxFit.cover,
                                      ),
                                      placeholderBuilder:
                                          (context, heroSize, child) =>
                                              ShaderMask(
                                                shaderCallback: (bounds) =>
                                                    RadialGradient(
                                                        radius: .9,
                                                        colors: [
                                                      Theme.of(context)
                                                          .primaryTextTheme
                                                          .headline2!
                                                          .color!,
                                                      Colors.black87
                                                    ]).createShader(bounds),
                                                child: child,
                                              )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height / 70,
                        ),
                        child: Text(
                          title[pageIndex],
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width / 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
