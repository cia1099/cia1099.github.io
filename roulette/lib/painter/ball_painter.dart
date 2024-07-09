part of roulette;

class _BallPainter extends CustomPainter {
  final Animation<double> progress;
  final double diameter;

  final int nextIndex;
  late final Size ballSize;
  late final Animatable<double> theta;

  static double lastTheta = _locationThetas[0];

  final ballColor = const RadialGradient(
      colors: [Colors.white, Colors.grey], center: Alignment(-0.5, -0.75));

  _BallPainter({
    required this.progress,
    required this.diameter,
    required this.nextIndex,
  }) : super(repaint: progress) {
    ballSize = Size(diameter, diameter);
    theta = Tween(
            begin: lastTheta,
            end: _locationThetas[_originIndex
                    .indexWhere((element) => element == nextIndex)] -
                math.pi * 10)
        .chain(CurveTween(curve: Curves.decelerate));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final r = Tween(begin: size.height / 2, end: size.height / 3.5).chain(
        CurveTween(
            curve: const _FusionCurve(
                Curves.bounceIn,
                _JumpCurve(
                    timeShift: 0.771, amplitude: 0.4, f: 16, damping: 0.15))));
    final origin = Offset(size.width / 2, size.height / 2);
    final center =
        Offset.fromDirection(theta.evaluate(progress), r.evaluate(progress)) +
            origin;
    // final center = Offset.fromDirection(theta.transform(0), r.transform(1)) +
    //     origin; //debug

    // locationBlueprint(canvas, size, 37);
    final region =
        ballSize.topLeft(center.translate(-diameter / 2, -diameter / 2)) &
            ballSize;

    canvas.drawCircle(
        center,
        diameter / 2,
        Paint()
          ..shader = RadialGradient(
            colors: ballColor.colors,
            center: ballColor.center.add(Alignment(
                math.sin(theta
                    .chain(CurveTween(curve: Curves.easeInQuart))
                    .evaluate(progress)),
                -math.cos(theta
                    .chain(CurveTween(curve: Curves.easeInQuart))
                    .evaluate(progress)))),
          ).createShader(region));
    if (progress.isCompleted) {
      lastTheta = theta.transform(1) + 10 * math.pi;
    }
  }

  void locationBlueprint(Canvas canvas, Size size, int devideN) {
    final origin = Offset(size.width / 2, size.height / 2);
    final dradius = math.pi * 2 / devideN;
    final locationThetas = List.generate(
        devideN, (i) => -math.pi / 2 + i * dradius,
        growable: false);
    for (int i = 0; i < devideN; i++) {
      final edge =
          Offset.fromDirection(locationThetas[i], size.height / 2) + origin;
      canvas.drawLine(origin, edge, Paint()..color = Colors.green);
    }
  }

  @override
  bool shouldRepaint(covariant _BallPainter oldDelegate) =>
      diameter == oldDelegate.diameter ? false : true;
}

class _JumpCurve extends Curve {
  const _JumpCurve({
    this.timeShift = 0,
    this.damping = math.sqrt1_2,
    this.f = 10,
    this.amplitude = 1,
  });
  final double f;
  final double damping;
  final double timeShift;
  final double amplitude;

  @override
  double transformInternal(double t) {
    final rad =
        2 * math.pi * f * math.sqrt(1 - math.pow(damping, 2).clamp(0, 1));
    final lambda = 2 * math.pi * f * damping;
    final dt = timeShift.clamp(0, 1);
    return t < dt
        ? 0
        : (math.pow(math.e, -(t - dt) * lambda) *
                math.cos((t - dt) * rad - math.pi / 2).abs()) *
            -amplitude;
  }
}

class _FusionCurve extends Curve {
  final Curve curve1;
  final Curve curve2;

  const _FusionCurve(this.curve1, this.curve2);

  @override
  double transformInternal(double t) {
    return curve1.transform(t) + curve2.transform(t);
  }
}
