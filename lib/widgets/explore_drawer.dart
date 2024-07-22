import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';

class ExploreDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> innerScaffoldKey;
  const ExploreDrawer({
    Key? key,
    required this.innerScaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langDict = {"en": "English", "zh_CN": "简体中文", "zh_TW": "繁體中文"};
    return Drawer(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                  'login',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'sign_up',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).popAndPushNamed(MyApp.experience),
                child: Text(
                  'work_experience',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'contact',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    innerScaffoldKey.currentState?.openDrawer();
                  },
                  child: Text(
                    langDict[context.locale.toStringWithSeparator()] ?? 'error',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | Otto Lin',
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
