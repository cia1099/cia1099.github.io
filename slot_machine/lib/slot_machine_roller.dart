part of slot_machine;

class SlotMachineRoller extends StatefulWidget {
  const SlotMachineRoller({
    super.key,
    required this.height,
    required this.width,
    required this.itemBuilder,
    this.target,
    this.reverse = false,
    this.period = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
  });

  final double height, width;
  final bool reverse;
  final Duration period, delay;
  final Widget Function(int number) itemBuilder;
  final int? target;

  @override
  State<SlotMachineRoller> createState() => _SlotMachineRollerState();
}

class _SlotMachineRollerState extends State<SlotMachineRoller> {
  final scrollController = ScrollController(keepScrollOffset: false);
  final rng = Random();
  bool pipeClosed = true;

  late Stream<int> pipe;
  int? before;

  @override
  Widget build(BuildContext context) {
    if (pipeClosed) {
      pipe = startPipe();
    }
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: StreamBuilder(
          stream: pipe,
          builder: (context, snapshot) {
            final data = snapshot.data;
            final cached = before == null
                ? <int>[]
                : <int>[before!] +
                    (List.generate(widget.period.inMilliseconds ~/ 125,
                        (index) => 1 + rng.nextInt(6)));
            if (data != null) {
              cached.add(data);
              before = data;
            }
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                scrollController.jumpTo(0);
                final curve =
                    !pipeClosed ? Curves.linear : Curves.fastLinearToSlowEaseIn;
                final duration = !pipeClosed
                    ? widget.period
                    : Duration(milliseconds: widget.period.inMilliseconds * 5);
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: duration,
                    curve: curve);
              },
            );
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              reverse: widget.reverse,
              child: Column(
                  children: (widget.reverse ? cached.reversed : cached)
                      .map(widget.itemBuilder)
                      .toList()),
            );
          },
        ),
      ),
    );
  }

  Stream<int> startPipe() async* {
    pipeClosed = false;
    final lastData = before ?? widget.target ?? rng.nextInt(6) + 1;
    before = null;
    yield lastData;
    await Future.delayed(widget.delay);
    before = null;
    while (widget.target == null) {
      yield before == null ? lastData : rng.nextInt(6) + 1;
      await Future.delayed(widget.period);
    }
    pipeClosed = true;
    yield widget.target!;
  }
}
