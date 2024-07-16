import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;
  final bool doubleDot;

  InfoText({required this.type, required this.text, this.doubleDot = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(text: '${type.tr()}'),
            if (doubleDot) TextSpan(text: ': '),
          ]),
          style: TextStyle(
            color: Colors.blueGrey[300],
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
