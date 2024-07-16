import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomBarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;
  final hoverItem = ValueNotifier(0);
  final VoidCallback? onTap1, onTap2, onTap3;

  BottomBarColumn({
    required this.heading,
    this.s1 = "",
    this.s2 = "",
    this.s3 = "",
    this.onTap1,
    this.onTap2,
    this.onTap3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          SizedBox(
            height: 10,
          ),
          ...List.generate(
              3,
              (index) => ValueListenableBuilder(
                    valueListenable: hoverItem,
                    builder: (context, value, child) => Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: getItemOnTap(index),
                        onHover: (value) =>
                            hoverItem.value = value ? index + 1 : 0,
                        child: Text(
                          getItemContent(index),
                          style: TextStyle(
                            color: hoverItem.value == index + 1
                                ? Colors.blue[200]
                                : Colors.blueGrey[100],
                            fontSize: 14,
                          ),
                        ).tr(),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }

  String getItemContent(int i) {
    switch (i) {
      case 0:
        return s1;
      case 1:
        return s2;
      case 2:
        return s3;
    }
    return '';
  }

  VoidCallback? getItemOnTap(int i) {
    switch (i) {
      case 0:
        return onTap1;
      case 1:
        return onTap2;
      case 2:
        return onTap3;
    }
    return null;
  }
}
