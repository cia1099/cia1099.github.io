part of roulette;

class _SectorPainter extends CustomPainter {
  final int nextIndex;
  final Animation<double>? progress;

  _SectorPainter({this.progress, required this.nextIndex})
      : super(repaint: progress);
  @override
  void paint(Canvas canvas, Size size) {
    if (progress != null) {
      final blinker = Tween(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: const _SineCurve(f: 8)));
      if (blinker.evaluate(progress!) < 1e-3 || progress!.isCompleted) return;
    }

    final origin = Offset(size.width / 2, size.height / 2);
    final delta = math.pi * 2 / _locationThetas.length;
    final theta = _locationThetas[
        _originIndex.indexWhere((element) => element == nextIndex)];
    final pts1 =
        Offset.fromDirection(theta - delta / 2, size.height / 4) + origin;
    final pts2 =
        Offset.fromDirection(theta - delta / 2, size.height / 2) + origin;
    final pts3 =
        Offset.fromDirection(theta + delta / 2, size.height / 2) + origin;
    final pts4 =
        Offset.fromDirection(theta + delta / 2, size.height / 4) + origin;
    final path = Path()
      ..moveTo(pts1.dx, pts1.dy)
      ..lineTo(pts2.dx, pts2.dy)
      ..arcToPoint(pts3, radius: Radius.circular(size.height / 2))
      ..lineTo(pts4.dx, pts4.dy);

    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white54);
  }

  @override
  bool shouldRepaint(covariant _SectorPainter oldDelegate) =>
      nextIndex == oldDelegate.nextIndex ? false : true;
}

class _SineCurve extends Curve {
  const _SineCurve({this.f = 1});
  final double f;

  @override
  double transformInternal(double t) => math.sin(f * 2 * math.pi * t);
}
