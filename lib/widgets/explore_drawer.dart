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
    final isHover = List.filled(5, false);
    return Drawer(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  onHover: (value) => setState(() => isHover[0] = value),
                  child: Text(
                    'login',
                    style: TextStyle(
                        color: isHover[0] ? Colors.blue[200] : Colors.white,
                        fontSize: 22),
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
                  onHover: (value) => setState(() => isHover[1] = value),
                  child: Text(
                    'sign_up',
                    style: TextStyle(
                        color: isHover[1] ? Colors.blue[200] : Colors.white,
                        fontSize: 22),
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
                  onHover: (value) => setState(() => isHover[2] = value),
                  child: Text(
                    'work_experience',
                    style: TextStyle(
                        color: isHover[2] ? Colors.blue[200] : Colors.white,
                        fontSize: 22),
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
                  onHover: (value) => setState(() => isHover[3] = value),
                  child: Text(
                    'contact',
                    style: TextStyle(
                        color: isHover[3] ? Colors.blue[200] : Colors.white,
                        fontSize: 22),
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
                    onHover: (value) => setState(() => isHover[4] = value),
                    child: Text(
                      'language',
                      style: TextStyle(
                          color: isHover[4] ? Colors.blue[200] : Colors.white,
                          fontSize: 22),
                    ).tr()),
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
      ),
    );
  }
}
