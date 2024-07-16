import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  late final localeStream = StreamController<Locale>()..add(context.locale);
  final langDict = {"en": "English", "zh": "简体中文"};

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ).tr(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Discover',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'contact',
                            style: TextStyle(
                              color: _isHovering[1]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ).tr(),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                tooltip: "",
                position: PopupMenuPosition.under,
                itemBuilder: (context) {
                  final supportedLocales = context.supportedLocales;
                  final items = supportedLocales.map((locale) => PopupMenuItem(
                        value: locale,
                        child: Text(langDict[locale.languageCode] ?? "error"),
                      ));
                  return items.toList();
                },
                onSelected: (locale) {
                  context.setLocale(locale);
                  localeStream.add(locale);
                },
                child: StreamBuilder(
                    // initialData: context.locale,
                    stream: localeStream.stream,
                    builder: (context, snapshot) {
                      final lang = snapshot.data?.languageCode ?? "no";
                      return AnimatedSwitcher(
                        duration: Durations.short4,
                        transitionBuilder: (child, animation) =>
                            SlideTransition(
                                position: Tween(
                                        begin: const Offset(-0.5, -1),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: child),
                        child: Text(
                          langDict[lang] ?? "error",
                          key: Key(lang),
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }),
              ),
              IconButton(
                icon: Icon(Icons.brightness_6),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.white,
                onPressed: () {
                  EasyDynamicTheme.of(context).changeTheme();
                },
              ),
              SizedBox(width: 10),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[2] = true : _isHovering[2] = false;
                  });
                },
                onTap: () {},
                child: Text(
                  'sign_up',
                  style: TextStyle(
                    color: _isHovering[2] ? Colors.white : Colors.white70,
                  ),
                ).tr(),
              ),
              SizedBox(
                width: screenSize.width / 50,
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },
                onTap: () {},
                child: Text(
                  'login',
                  style: TextStyle(
                    color: _isHovering[3] ? Colors.white : Colors.white70,
                  ),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
