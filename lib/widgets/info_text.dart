import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;
  final bool doubleDot;
  final VoidCallback? onTap;
  final isHover = ValueNotifier(false);

  InfoText(
      {required this.type,
      required this.text,
      this.doubleDot = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: isHover,
          builder: (context, value, child) => InkWell(
            onHover: (value) => isHover.value = value,
            onTap: onTap,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: '${type.tr()}'),
                if (doubleDot) TextSpan(text: ': '),
              ]),
              style: TextStyle(
                color: isHover.value ? Colors.blue[200] : Colors.blueGrey[300],
                fontSize: 16,
              ),
            ),
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
