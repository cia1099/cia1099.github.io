import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/api/user_api.dart';
import 'package:portfolio/dialogs/contact_dialog.dart';
import 'package:portfolio/dialogs/login_dialog.dart';
import 'package:portfolio/main.dart';

import '../utils/global_data.dart' show langDict;

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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onHover: (value) => setState(() {
                _isHovering[6] = value;
              }),
              onTap: () => Navigator.of(context)
                  .popUntil((route) => route.settings.name == MyApp.home),
              child: Text(
                'profile',
                style: TextStyle(
                  color:
                      _isHovering[6] ? Colors.blue[200] : Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ).tr(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: screenSize.width / 8),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[0] = true : _isHovering[0] = false;
                      });
                    },
                    onTap: () {
                      Navigator.of(context).pushNamed(MyApp.experience);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'work_experience',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? Colors.blue[200]
                                : Colors.white,
                          ),
                        ).tr(),
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
                        value ? _isHovering[1] = true : _isHovering[1] = false;
                      });
                    },
                    onTap: () => showAdaptiveDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => ContactMeDialog(),
                    ),
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
            MouseRegion(
              onEnter: (event) => setState(() {
                _isHovering[4] = true;
              }),
              onExit: (event) => setState(() {
                _isHovering[4] = false;
              }),
              child: PopupMenuButton(
                tooltip: "language".tr(),
                position: PopupMenuPosition.under,
                itemBuilder: (context) {
                  final supportedLocales = context.supportedLocales;
                  final items = supportedLocales.map((locale) => PopupMenuItem(
                        value: locale,
                        child: Text(langDict[locale.toStringWithSeparator()] ??
                            "error"),
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
                      final lang =
                          snapshot.data?.toStringWithSeparator() ?? "no";
                      return Text(
                        langDict[lang] ?? "language".tr(),
                        key: Key(lang),
                        style: TextStyle(
                            color: _isHovering[4]
                                ? Colors.blue[200]
                                : Colors.white70),
                      );
                    }),
              ),
            ),
            MouseRegion(
              onEnter: (event) => setState(() {
                _isHovering[5] = true;
              }),
              onExit: (event) => setState(() {
                _isHovering[5] = false;
              }),
              child: IconButton(
                icon: Icon(Icons.brightness_6),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: _isHovering[5] ? Colors.blue[200] : Colors.white70,
                onPressed: () {
                  EasyDynamicTheme.of(context).changeTheme();
                },
              ),
            ),
            SizedBox(width: 10),
            StreamBuilder(
                stream: UserAPI.instance.authStateQueue,
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  return InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[2] = true : _isHovering[2] = false;
                      });
                    },
                    onTap: user == null
                        ? () => showAdaptiveDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) =>
                                  LoginDialog(isCreatedAccountClicked: true),
                            )
                        : null,
                    child: Text(
                      user == null ? 'sign_up'.tr() : 'Hi, ${user.email}',
                      style: TextStyle(
                        color:
                            _isHovering[2] ? Colors.blue[200] : Colors.white70,
                      ),
                    ),
                  );
                }),
            SizedBox(
              width: screenSize.width / 50,
            ),
            StreamBuilder(
                stream: UserAPI.instance.authStateQueue,
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  return InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[3] = true : _isHovering[3] = false;
                      });
                    },
                    onTap: user == null
                        ? () => showAdaptiveDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => LoginDialog(),
                            )
                        : UserAPI().logout,
                    child: Text(
                      user == null ? 'login' : 'logout',
                      style: TextStyle(
                        color:
                            _isHovering[3] ? Colors.blue[200] : Colors.white70,
                      ),
                    ).tr(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
