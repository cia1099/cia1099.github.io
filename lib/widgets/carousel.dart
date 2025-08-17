import 'dart:isolate';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/game_widgets.dart';
import 'package:portfolio/widgets/responsive.dart';

class DecodeParam {
  final ByteData byteData;
  final SendPort sendPort;

  DecodeParam(this.byteData, this.sendPort);
}

class DestinationCarousel extends StatefulWidget {
  const DestinationCarousel({super.key});

  @override
  _DestinationCarouselState createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel>
    with TickerProviderStateMixin {
  final String imagePath = 'assets/images/';

  late CarouselController _controller; // = CarouselController();
  late List<Widget> imageSliders;
  // late Locale locale;

  final List _isHovering = [false, false, false, false, false, false, false];
  final List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;
  List<Widget>? txtSliders;

  final List<String> places = [
    'roulette',
    'fast_furious',
    'slot_machine',
    'dice',
  ];

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    // if (txtSliders == null) {
    // for localization rebuild language
    imageSliders = [
      createRoulette(const Duration(seconds: 7)),
      createFastFurious(const Duration(seconds: 5)),
      createSlotMachine(const Duration(seconds: 4)),
      createDice(const Duration(seconds: 4), context),
    ];
    txtSliders = generateTextTiles(screenSize, context);
    txtSliders![_current] = _createTextTiles(
        screenSize, places[_current], Colors.white.withOpacity(0.7));
    // }
    final isSmall = ResponsiveWidget.isSmallScreen(context);

    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: screenSize.width * (isSmall ? 0.85 : 3 / 4),
            child: AspectRatio(
              aspectRatio: isSmall ? 4 / 3 : 16 / 9,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: const Offset(0, 0))
                            .animate(animation),
                        child: child,
                      ),
                  child: ClipRRect(
                      key: ValueKey(_current),
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/newbackground.png'),
                                  fit: BoxFit.fill)),
                          child: imageSliders[_current]))),
            ),
          ),
        ),
        CarouselSlider(
          items: txtSliders,
          options: CarouselOptions(
            viewportFraction: isSmall ? 1 : 0.6,
            enlargeCenterPage: true,
            aspectRatio: 18 / 8,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 15),
            onPageChanged: (index, reason) {
              txtSliders![_current] = _createTextTiles(screenSize,
                  places[_current], Theme.of(context).bottomAppBarColor);
              setState(() {
                _current = index;
                for (int i = 0; i < txtSliders!.length; i++) {
                  if (i == index) {
                    _isSelected[i] = true;
                    txtSliders![i] = _createTextTiles(
                        screenSize, places[i], Colors.white.withOpacity(0.7));
                  } else {
                    _isSelected[i] = false;
                  }
                }
              });
            },
          ),
          carouselController: _controller,
        ),
        if (isSmall)
          AspectRatio(
            aspectRatio: 1.565,
            child: Align(
                alignment: const Alignment(0, 1),
                child: Container(
                  width: screenSize.width / 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(kRadialReactionRadius),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        places.length,
                        (index) => GestureDetector(
                              onTap: () {
                                _controller.animateToPage(index);
                              },
                              child: TabPageSelectorIndicator(
                                  backgroundColor: index == _current
                                      ? Colors.white
                                      : Colors.grey[700]!,
                                  borderColor: const Color(0x00000000),
                                  size: 12),
                            )),
                  ),
                )),
          )
        else
          AspectRatio(
            aspectRatio: 17 / 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width / 8,
                  right: screenSize.width / 8,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height / 50,
                      bottom: screenSize.height / 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < places.length; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) => InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onHover: (value) {
                                    setState(() {
                                      _isHovering[i] = value;
                                    });
                                  },
                                  onTap: () {
                                    _controller.animateToPage(i);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: screenSize.height / 80,
                                        bottom: screenSize.height / 90),
                                    child: Text(
                                      places[i].tr(),
                                      style: TextStyle(
                                        color: _isHovering[i]
                                            ? Theme.of(context)
                                                .primaryTextTheme
                                                .labelLarge!
                                                .decorationColor
                                            : Theme.of(context)
                                                .primaryTextTheme
                                                .labelLarge!
                                                .color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: _isSelected[i],
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 400),
                                  opacity: _isSelected[i] ? 1 : 0,
                                  child: Container(
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    width: screenSize.width / 10,
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> generateTextTiles(screenSize, ctx) {
    return places
        .map((e) => Align(
              alignment: const FractionalOffset(0.5, 0.1),
              child: AutoSizeText(
                e.tr(),
                style: GoogleFonts.electrolize(
                  letterSpacing: 8,
                  fontSize: screenSize.width / 16,
                  color: Theme.of(ctx).bottomAppBarColor,
                ),
                maxLines: 1,
              ),
            ))
        .toList();
  }

  Widget _createTextTiles(screenSize, String str, myColor) {
    return Align(
      alignment: const FractionalOffset(0.5, 0.1),
      child: AutoSizeText(
        str.tr(),
        style: GoogleFonts.electrolize(
          letterSpacing: 8,
          fontSize: screenSize.width / 16,
          color: myColor,
        ),
        maxLines: 1,
      ),
    );
  }
}
