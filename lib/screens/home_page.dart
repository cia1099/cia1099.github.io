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
  var isHover = false;
  final innerScaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? generateAppBar(context)
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: ExploreDrawer(innerScaffoldKey: innerScaffoldKey),
      body: Scaffold(
        key: innerScaffoldKey,
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
                            height: 200,
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
                                    child: SelectableText(
                                        "introduce.rough".tr(),
                                        // textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.8),
                                        )),
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
                  AboutMe(),
                  // SizedBox(height: screenSize.height / 8),
                  DestinationHeading(screenSize: screenSize),
                  DestinationCarousel(),
                  SizedBox(height: screenSize.height / 10),
                  BottomBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar generateAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
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
      title: InkWell(
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
    );
  }
}
