import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utils/input_decorator.dart';

class ContactMeDialog extends StatelessWidget {
  const ContactMeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final nameTextController = TextEditingController();
    final contentTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var isHover = false;
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth * .8;
          final isSmall = width < 640;
          return Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Text(
                  'Mail me a message!',
                  style: TextStyle(
                      fontSize: isSmall ? 24 : 40,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'Got a question or proposal, or just want to say hello? Go ahead.',
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
                SizedBox(height: width * .1),
                Form(
                  key: formKey,
                  child: Wrap(
                    spacing: width * .1,
                    runSpacing: width * .05,
                    children: [
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: nameTextController,
                          decoration: buildInputDecoration(
                              context, 'Your Name', 'Leave your name'),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: emailTextController,
                          decoration: buildInputDecoration(
                              context, 'Email', 'Enter your email'),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        width: width * .8,
                        height: 200,
                        // color: Colors.green,
                        child: TextFormField(
                          controller: contentTextController,
                          decoration: buildInputDecoration(
                              context,
                              'Your Message',
                              'Hi, I am looking forward to your message.'),
                          textInputAction: TextInputAction.next,
                          maxLines: null,
                          expands: true,
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                StatefulBuilder(
                  builder: (context, setState) => TextButton(
                    onPressed: () {},
                    onHover: (value) => setState(() => isHover = value),
                    style: TextButton.styleFrom(
                        primary: isHover
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).primaryTextTheme.button!.color!,
                        fixedSize: Size(150, 36),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2!
                                    .color!),
                            borderRadius: BorderRadius.circular(4)),
                        textStyle: TextStyle(fontSize: 18)),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Durations.short4,
                          width: isHover ? 150 : 0,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2!
                                  .color!,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                        ),
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Shoot'),
                                Transform(
                                    transform: Matrix4.diagonal3Values(4, 1, 1)
                                      ..translate(-7),
                                    child: Icon(CupertinoIcons.arrow_right,
                                        size: 18)),
                                Icon(CupertinoIcons.mail, size: 18)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          );
        },
      ),
    );
  }
}
