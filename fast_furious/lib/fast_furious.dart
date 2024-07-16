library fast_furious;

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui show Image, ImageFilter;

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

part 'utilts.dart';

class FastFuriousAnimation extends StatefulWidget {
  FastFuriousAnimation({
    Key? key,
    this.numbers,
    this.child,
    required this.leavedTime,
    required this.sampleY,
    required this.shuffleCarImg,
    this.size = Size.infinite,
    this.duration = const Duration(seconds: 5),
  }) : super(key: key) {
    leavedTime = leavedTime.clamp(0, duration.inSeconds);
  }
  final Widget? child;
  final List<int>? numbers;
  final List<int> sampleY;
  final List<int> shuffleCarImg;

  final Size size;
  final Duration duration;
  @protected
  int leavedTime;

  @override
  State<FastFuriousAnimation> createState() => _FastFuriousAnimationState();
}

class _FastFuriousAnimationState extends State<FastFuriousAnimation>
    with SingleTickerProviderStateMixin {
  late Future<List<ui.Image>>? images = _fetchFastFuriousImages(context);
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late List<Animatable<double>> moveX =
      List<Animatable<double>>.filled(12, Tween(begin: 0, end: 0));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: images,
      builder: (context, AsyncSnapshot<List<ui.Image>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.child ?? const CircularProgressIndicator.adaptive();
        }
        return LayoutBuilder(
          builder: (_, constraints) {
            final width = widget.size.width.isInfinite
                ? constraints.maxWidth
                : widget.size.width;
            final height = widget.size.height.isInfinite
                ? constraints.maxHeight
                : widget.size.height;
            final localSize = Size(width, height);
            double roadGap = localSize.height / 40;
            final rect =
                Offset(constraints.minWidth, constraints.minHeight) & localSize;
            _distributeX(rect, roadGap);
            controller.forward(
                from: 1 - widget.leavedTime / widget.duration.inSeconds);
            return CustomPaint(
              painter: _RoadPainter(
                  images: snapshot.data!,
                  progress: controller,
                  moveX: moveX,
                  sampleY: widget.sampleY,
                  numbers: widget.numbers,
                  shuffleCarImg: widget.shuffleCarImg),
              size: localSize,
              child: widget.child,
            );
          },
        );
      },
    );
  }

  void _distributeX(Rect rect, double roadGap) {
    final startX1 = rect.right;
    final startX2 = startX1 + rect.width / 8;
    final startX3 = startX2 + rect.width / 8;
    double endX2 = rect.right / 4 + rect.width / 8;
    double endX3 = rect.right - rect.width / 5;

    moveX[0] = Tween(begin: startX1, end: rect.right * (1 / 4 - 1 / 16))
        .chain(CurveTween(curve: Curves.easeOutCubic));
    moveX[1] = Tween(begin: startX1, end: rect.right / 4 - roadGap * 3)
        .chain(CurveTween(curve: Curves.decelerate))
        .chain(CurveTween(curve: Curves.easeOutSine));
    for (int i = 2; i < 6; i++) {
      final endX = endX2 + math.sin(math.pi / 8 * (i - 1.5)) * rect.width / 6;
      if (i < 4) {
        moveX[i] = Tween(begin: startX1, end: endX)
            .chain(CurveTween(curve: Curves.elasticOut));
      } else {
        moveX[i] = Tween(begin: startX2, end: endX);
      }
    }
    for (int i = 6; i < 10; i++) {
      final endX = endX3 - math.cos(math.pi / 8 * (i - 5)) * rect.width / 8;
      if (i < 8) {
        moveX[i] = Tween(begin: startX2, end: endX);
      } else {
        moveX[i] = Tween(begin: startX3, end: endX);
      }
    }
    moveX[10] = Tween(
        begin: rect.right * 0.875,
        end: rect.right * 0.875 +
            rect.right / 4 * (widget.duration.inSeconds - 1));
    moveX[11] = Tween(
        begin: rect.right / 4 * (1 - widget.duration.inSeconds),
        end: rect.right / 4);
  }
}

Future<List<ui.Image>> _fetchFastFuriousImages(BuildContext? context) async {
  final images = <ui.Image>[];
  const packPath = 'packages/fast_furious';
  for (int i = 0; i < 10; i++) {
    final path =
        p.join(packPath, 'assets', 'car${i.toString().padLeft(2, '0')}.png');
    final img = await dartDecodeImage(path, context);
    images.add(img);
  }

  images.add(
      await dartDecodeImage(p.join(packPath, 'assets', 'start.png'), context));
  images.add(
      await dartDecodeImage(p.join(packPath, 'assets', 'goal.png'), context));
  return images;
}

class _RoadPainter extends CustomPainter {
  final Animation<double>? progress;
  final List<ui.Image> images;
  final List<Animatable<double>> moveX;
  final List<int> sampleY;
  final List<int> shuffleCarImg;
  final List<int>? numbers;

  static const List<Color> colors = [
    Color(0x00102D45),
    Color(0x4D102D45),
    Color(0x80102D45),
    Color(0x4D102D45),
    Color(0x00102D45),
  ];
  static const colorStops = [0.0, 0.09, 0.51, 0.93, 1.0];

  _RoadPainter({
    required this.sampleY,
    required this.shuffleCarImg,
    required this.moveX,
    required this.images,
    this.numbers,
    this.progress,
  }) : super(repaint: progress);

  List<Color> _recycleColors(List<Color> colors, int start) {
    final cycleColors = colors.sublist(start) + colors.sublist(0, start);
    if (progress!.status == AnimationStatus.forward) {
      return cycleColors.reversed.toList();
    }
    return cycleColors;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double roadGap = size.height / 40;
    double roadHeight = (size.height - 3 * roadGap) / 4;
    final rect = Offset.zero & size;
    //===== paint road
    final roadPaint = Paint()
      ..shader = LinearGradient(
        colors: _recycleColors(
            colors, (25 * progress!.value).round() % colors.length),
        stops: colorStops,
      ).createShader(rect)
      ..strokeWidth = roadHeight
      ..style = PaintingStyle.stroke;

    final roadPath = Path()
      ..moveTo(rect.left, roadHeight / 2)
      ..lineTo(rect.right, roadHeight / 2);
    final roadGridY = List<double>.filled(4, roadHeight / 2);
    for (int i = 0; i < 4; i++) {
      canvas.drawPath(
          roadPath.shift(Offset(0, i * (roadGap + roadHeight))), roadPaint);
      roadGridY[i] += i * (roadGap + roadHeight);
    }

    final carSize = Size(size.width / 8, roadHeight - roadGap / 2);
    final lineSize = Size(roadGap * 3, size.height);
    for (int i = moveX.length - 1; i > -1; i--) {
      final dx = progress!.drive(moveX[i]).value;
      if (!rect.contains(Offset(dx, rect.center.dy))) continue;
      Size drawSize;
      Offset position;
      if (i < 10) {
        drawSize = carSize;
        position = Offset(dx, roadGridY[sampleY[i]]);
      } else {
        drawSize = lineSize;
        position = Offset(dx, rect.center.dy);
      }
      final object = _FastFuriousObject(
        canvas: canvas,
        image: images[i < 10 ? shuffleCarImg[i] : i],
        size: drawSize,
        position: position,
      );
      if (progress!.isCompleted && i < 10) {
        object.showNumber(numbers?.elementAt(i));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FastFuriousObject {
  final Canvas canvas;
  final Offset position;
  final ui.Image image;
  Size? size;

  _FastFuriousObject({
    required this.canvas,
    required this.position,
    required this.image,
    this.size,
  }) {
    Size size =
        this.size ?? Size(image.width.toDouble(), image.height.toDouble());
    final se3 = Matrix4.identity()
      ..setEntry(0, 0, size.width / image.width)
      ..setEntry(1, 1, size.height / image.height)
      ..setEntry(0, 3, position.dx - size.width)
      ..setEntry(1, 3, position.dy - size.height / 2);

    canvas.drawImage(image, Offset.zero,
        Paint()..imageFilter = ui.ImageFilter.matrix(se3.storage));
  }

  void showNumber(int? number) {
    if (number == null) return;
    Size size =
        this.size ?? Size(image.width.toDouble(), image.height.toDouble());
    final radius = size.height / 4;
    final center = position + Offset(4 + radius, 0);
    canvas.drawCircle(center, radius, Paint()..color = Colors.brown);
    final strNumber = '$number';
    final textPainter = TextPainter(
        text: TextSpan(
            text: strNumber,
            style: TextStyle(
                color: Colors.white,
                fontSize: radius * 1.5,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr)
      ..layout(
        maxWidth: size.height,
      );
    final textRect = Offset.zero & textPainter.size;
    textPainter.paint(canvas, center - textRect.center);
  }
}
