import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/global_data.dart' show langDict;

class LanguageDrawer extends StatelessWidget {
  const LanguageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final supportedLocales = context.supportedLocales;
    final isHover = List.filled(supportedLocales.length, false);
    return Drawer(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              supportedLocales.length,
              (index) => [
                    StatefulBuilder(
                      builder: (context, setState) => InkWell(
                        onTap: () {
                          final selected = supportedLocales[index];
                          context.setLocale(selected);
                          Navigator.of(context).pop();
                        },
                        onHover: (value) =>
                            setState(() => isHover[index] = value),
                        child: Text(
                          langDict[supportedLocales[index]
                                  .toStringWithSeparator()] ??
                              'error',
                          style: TextStyle(
                              color: isHover[index]
                                  ? Colors.blue[200]
                                  : Colors.white,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    if (index < supportedLocales.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Divider(
                          color: Colors.blueGrey[400],
                          thickness: 2,
                        ),
                      ),
                  ]).expand((list) sync* {
            for (var i in list) yield i;
          }).toList(),
        ),
      ),
    );
  }
}
