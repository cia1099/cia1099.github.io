import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;
  final bool doubleDot;
  final VoidCallback? onTap;

  InfoText(
      {required this.type,
      required this.text,
      this.doubleDot = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var isHover = false;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          '${type.tr()}: ',
          style: TextStyle(
            color: Colors.blueGrey[300],
            fontSize: 16,
          ),
        ),
        Flexible(
          child: StatefulBuilder(
            builder: (context, setState) => InkWell(
              onHover: (value) => setState(() => isHover = value),
              onTap: onTap,
              child: SelectableText(
                '${onTap == null ? text : text.tr()}',
                style: TextStyle(
                  color: isHover ? Colors.blue[200] : Colors.blueGrey[100],
                  fontSize: 16,
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
