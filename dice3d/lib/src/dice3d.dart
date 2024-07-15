import 'dart:math' show Random, pi;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:zflutter/zflutter.dart';

import 'dice.dart';

class Dice3D extends StatefulWidget {
  final Duration duration;
  final List<int> points;
  const Dice3D({
    super.key,
    required this.duration,
    this.points = const [1, 1, 1],
  });

  @override
  State<Dice3D> createState() => _Dice3DState();
}

class _Dice3DState extends State<Dice3D> with SingleTickerProviderStateMixin {
  late final progress =
      AnimationController(vsync: this, duration: widget.duration)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            lastPoints = widget.points;
          }
        });
  final spring = SpringSimulation(
    const SpringDescription(
      mass: 1,
      stiffness: 20,
      damping: 2,
    ),
    1, // starting point
    0, // ending point
    1, // velocity
  );
  late final fallZoom =
      CurvedAnimation(parent: progress, curve: Interval(0.4, 1));
  late final riseZoom = Tween(begin: spring.x(0).abs(), end: spring.x(1).abs())
      .chain(CurveTween(curve: Interval(0.1, 0.25)))
      .animate(progress);
  // CurvedAnimation(
  //     parent: Tween(begin: spring.x(0).abs(), end: spring.x(1).abs())
  //         .animate(progress),
  //     curve: Interval(0, 0.2)); //error used
  late var lastPoints = List.filled(widget.points.length, 1);
  late var zRotations = List.filled(widget.points.length, .0);

  //----- rotation animation
  late final rotateCurve =
      CurveTween(curve: Interval(0.5, 1, curve: Curves.ease)).animate(progress);

  @override
  Widget build(BuildContext context) {
    if (progress.isCompleted) {
      progress.reset();
      zRotations = List.generate(
          lastPoints.length, (_) => pi * (1 - 2 * Random().nextDouble()));
    }
    progress.forward();
    final targetRotates = List.generate(
        widget.points.length, (i) => getRotation(widget.points[i]));
    final lastRotates =
        List.generate(lastPoints.length, (i) => getRotation(lastPoints[i]));
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final scale = width / 900;
        final offsetX = width / lastPoints.length;
        return ZIllustration(
          zoom: scale,
          children: List.generate(widget.points.length, (index) {
            final mid = lastPoints.length ~/ 2;
            final dx = lastPoints.length & 1 > 0 ? 0 : 0.5;
            return ZPositioned.translate(
                x: offsetX * (index - mid + dx) / scale,
                child: AnimatedBuilder(
                  animation: progress,
                  builder: (context, child) {
                    final zoom =
                        (spring.x(fallZoom.value).abs() - riseZoom.value) / 2 +
                            0.5;
                    final showR = ZVector(-1, -1, 0).multiplyScalar(
                        widget.duration.inSeconds * 2 * pi * progress.value);
                    final rot =
                        targetRotates[index].multiplyScalar(rotateCurve.value) +
                            lastRotates[index]
                                .multiplyScalar(1 - rotateCurve.value);
                    return ZGroup(children: [
                      ZPositioned(
                          scale: ZVector.all(2 * zoom),
                          rotate: rot + showR,
                          child: ZPositioned.rotate(
                              z: zRotations[index] * rotateCurve.value,
                              child: Dice(zoom: 2 * zoom))),
                    ]);
                  },
                ));
          }),
        );
      },
    );
  }

  ZVector getRotation(int num) {
    switch (num) {
      case 1:
        return ZVector.zero;
      case 2:
        return ZVector.only(x: tau / 4);
      case 3:
        return ZVector.only(y: tau / 4);
      case 6:
        return ZVector.only(y: 3 * tau / 4);
      case 5:
        return ZVector.only(x: 3 * tau / 4);
      case 4:
        return ZVector.only(y: tau / 2);
    }
    throw ('num $num is not in the dice');
  }

  @override
  void dispose() {
    progress.dispose();
    super.dispose();
  }
}
