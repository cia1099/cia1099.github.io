part of roulette;

class RouletteAnimation extends StatefulWidget {
  final Duration duration;
  final double diameter;
  final int targetNumber;

  const RouletteAnimation({
    super.key,
    required this.duration,
    required this.diameter,
    required this.targetNumber,
  });

  @override
  State<RouletteAnimation> createState() => _RouletteAnimationState();
}

class _RouletteAnimationState extends State<RouletteAnimation>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final AnimationController blinkController;
  late int nextIndex;
  late double dTheta;
  late Animatable<double> angles;
  late final targetNumber = ValueNotifier(widget.targetNumber);
  @override
  void initState() {
    super.initState();
    targetNumber.addListener(() {
      controller.forward(from: 0);
    });
    controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 500),
              () => blinkController.forward(from: 0));
        }
        if (status == AnimationStatus.forward) {
          setEnding();
        }
      });
    blinkController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    setEnding();
    controller.forward(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    targetNumber.value = widget.targetNumber;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/outside_bowl.png",
          width: widget.diameter,
          fit: BoxFit.fitWidth,
          package: "roulette",
        ),
        CustomPaint(
          foregroundPainter:
              _SectorPainter(nextIndex: nextIndex, progress: blinkController),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Transform.rotate(
              angle: angles.animate(controller).value,
              child: child,
            ),
            child: Image.asset(
              'assets/roulette.png',
              width: widget.diameter * 0.75,
              fit: BoxFit.fitWidth,
              package: "roulette",
            ),
          ),
        ),
        CustomPaint(
          foregroundPainter: _BallPainter(
              diameter: widget.diameter / 20,
              nextIndex: nextIndex,
              progress: controller),
          size: Size(widget.diameter * 0.8, widget.diameter * 0.8),
        ),
      ],
    );
  }

  void setEnding() {
    nextIndex = math.Random().nextInt(_originIndex.length);
    dTheta = _locationThetas[
            _originIndex.indexWhere((theta) => theta == nextIndex)] -
        _locationThetas[
            _originIndex.indexWhere((theta) => theta == targetNumber.value)];
    angles = Tween(begin: 0.0, end: 4 * 2 * math.pi + dTheta)
        .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn));
    setState(() {});
  }
}
