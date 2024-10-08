import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/widgets/about_me.dart';
import 'package:portfolio/widgets/language_drawer.dart';
import 'package:portfolio/widgets/web_scrollbar.dart';
import 'package:portfolio/widgets/bottom_bar.dart';
import 'package:portfolio/widgets/carousel.dart';
import 'package:portfolio/widgets/destination_heading.dart';
import 'package:portfolio/widgets/explore_drawer.dart';
import 'package:portfolio/widgets/featured_heading.dart';
import 'package:portfolio/widgets/featured_tiles.dart';
// import 'package:portfolio/widgets/floating_quick_access_bar.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:portfolio/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  final innerScaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final aboutMeKey = GlobalKey();
  late var screenSize = MediaQuery.of(context).size;

  _scrollListener() {
    _scrollPosition = _scrollController.position.pixels;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    final appBarSize =
        Size(screenSize.width, kToolbarHeight + (isSmall ? 0 : 40));
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) => _opacity > .95
              ? child!
              : isSmall
                  ? generateAppBar(context, _opacity)
                  : TopBarContents(_opacity),
          child: isSmall ? generateAppBar(context, 1) : TopBarContents(1.0),
        ),
      ),
      drawer: ExploreDrawer(innerScaffoldKey: innerScaffoldKey),
      body: Scaffold(
        key: innerScaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: LanguageDrawer(),
        body: WebScrollbar(
          color: Colors.red,
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          width: 10,
          heightFraction: 0.3,
          controller: _scrollController,
          //ref. https://stackoverflow.com/questions/67662141/flutter-how-to-hide-a-scrollbarthumb-in-scrollable-widgets-like-listview-build
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              child: SelectionArea(
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey,
                      height: screenSize.height * 0.45,
                      width: screenSize.width,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/cover.jpg',
                            width: screenSize.width,
                            height: screenSize.height * 0.45,
                            fit: BoxFit.cover,
                          ),
                          // FloatingQuickAccessBar(screenSize: screenSize),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              // margin: EdgeInsets.only(top: 50),
                              height: 210,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        MyApp.monitorUrl +
                                            '/profile/assets/otto.jpeg'),
                                    radius: screenSize.width / 20,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width / 15),
                                    color: Colors.black12,
                                    child: Transform.translate(
                                      offset: Offset(0, 20),
                                      child: Text("introduce.rough",
                                          // textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Montserrat',
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          )).tr(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          FeaturedHeading(
                            screenSize: screenSize,
                          ),
                          FeaturedTiles(screenSize: screenSize)
                        ],
                      ),
                    ),
                    AboutMe(key: aboutMeKey),
                    // SizedBox(height: screenSize.height / 8),
                    DestinationHeading(screenSize: screenSize),
                    DestinationCarousel(),
                    SizedBox(height: screenSize.height / 10),
                    BottomBar(scrollCall: scrollToAboutMe),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void scrollToAboutMe() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    final renderBox =
        aboutMeKey.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    // print('\x1b[43mAboutMe at = $offset, size = ${renderBox.size}\x1b[0m');
    // final scrollAt = _scrollController.position.pixels;
    // print('\x1b[42mscroll at $scrollAt\x1b[0m');
    _scrollController.animateTo(offset.dy.abs() + renderBox.size.height * 1.3,
        duration: Durations.extralong1, curve: Curves.ease);
  }

  AppBar generateAppBar(BuildContext context, double opacity) {
    var isHover = false;
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
