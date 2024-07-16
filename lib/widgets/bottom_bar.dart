import 'package:portfolio/widgets/bottom_bar_column.dart';
import 'package:portfolio/widgets/info_text.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Theme.of(context).bottomAppBarColor,
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarColumn(
                      heading: 'about',
                      s1: 'contact',
                      s2: 'about_me',
                      s3: 'work_experience',
                    ),
                    // BottomBarColumn(
                    //   heading: 'resume',
                    //   s1: 'Payment',
                    //   s2: 'Cancellation',
                    //   s3: 'FAQ',
                    // ),
                    BottomBarColumn(
                      heading: 'community',
                      s1: 'github',
                      s2: 'linkin',
                      s3: 'medium',
                    ),
                  ],
                ),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                SizedBox(height: 20),
                InfoText(
                  type: 'email',
                  text: 'otto@cia1099.cloudns.ch',
                ),
                SizedBox(height: 5),
                InfoText(
                  type: 'resume',
                  text: '', //'128, Trymore Road, Delft, MN - 56124',
                  doubleDot: false,
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.blueGrey,
                  width: double.maxFinite,
                  height: 1,
                ),
                SizedBox(height: 20),
                Text(
                  'Copyright © 2024 | Otto Lin',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarColumn(
                      heading: 'about',
                      s1: 'contact',
                      s2: 'about_me',
                      s3: 'work_experience',
                    ),
                    // BottomBarColumn(
                    //   heading: 'resume',
                    //   // s1: 'Payment',
                    //   // s2: 'Cancellation',
                    //   // s3: 'FAQ',
                    // ),
                    BottomBarColumn(
                      heading: 'community',
                      s1: 'github',
                      s2: 'linkin',
                      s3: 'medium',
                    ),
                    Container(
                      color: Colors.blueGrey,
                      width: 2,
                      height: 150,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoText(
                          type: 'email',
                          text: 'otto@cia1099.cloudns.ch',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'resume',
                          text: '', //'128, Trymore Road, Delft, MN - 56124',
                          doubleDot: false,
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.blueGrey,
                    width: double.maxFinite,
                    height: 1,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Copyright © 2024 | Otto Lin',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}
