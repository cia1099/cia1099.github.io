import 'dart:async';
import 'dart:math';

import 'package:fast_furious/fast_furious.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _leavedTime = 5;
  late Stream timer;
  List<int>? numbers;
  GameStatus gameStatus = GameStatus.fengPei;
  late List<int> sampleY;
  late List<int> shuffleCarImg;

  void _changedState() {
    switch (gameStatus) {
      case GameStatus.fengPei:
        gameStatus = GameStatus.success;
        numbers = List<int>.generate(10, (index) => index + 1);
        _leavedTime = 0;

        break;
      case GameStatus.success:
        gameStatus = GameStatus.fengPei;
        _shuffleCar();
        numbers = null;
        _leavedTime = 5;
        break;
    }
    timer = resetTimer(_leavedTime);
    setState(() {});
  }

  void _shuffleCar() {
    final rng = Random();
    final set = <int>{};
    while (set.length < 10) {
      set.add(rng.nextInt(10));
    }
    shuffleCarImg = set.toList();
    set.clear();
    while (set.length < 4) {
      set.add(rng.nextInt(4));
    }
    sampleY =
        set.toList() + set.toList() + [set.elementAt(0), set.elementAt(1)];
  }

  Stream<int> resetTimer(int t) async* {
    yield t;
    if (t <= 0) return;
    yield* Stream.periodic(Duration(seconds: 1), (count) => t - 1 - count)
        .take(t);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timer = resetTimer(_leavedTime);
    _shuffleCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(children: [
        const Align(
          alignment: FractionalOffset(0.5, 0.7),
          child: Text(
            '速度与激情演示',
            style: TextStyle(color: Colors.grey, fontSize: 36),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.5, 0.85),
          child: StreamBuilder(
            key: const ValueKey(112),
            stream: timer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 96, color: Colors.greenAccent),
                );
              }
              return SizedBox();
            },
          ),
        ),
        Align(
          alignment: FractionalOffset(0.5, 0.5),
          child: FastFuriousAnimation(
            key: const ValueKey(7),
            leavedTime: _leavedTime,
            size: Size(double.infinity, 200),
            numbers: numbers,
            sampleY: sampleY,
            shuffleCarImg: shuffleCarImg,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _changedState,
        tooltip: 'Simulated FengPei and Success Status',
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum GameStatus {
  success,
  fengPei,
}

class TimerBLoC {
  int seconds;
  StreamController _secondsStreamController = StreamController();
  Stream get secondsStream =>
      _secondsStreamController.stream.asBroadcastStream();
  StreamSink get secondsSink => _secondsStreamController.sink;

  TimerBLoC({this.seconds = 5});

  Future decreaseSeconds() async {
    await Future.delayed(const Duration(seconds: 1), () {
      seconds--;
      secondsSink.add(seconds);
    });
  }

  countDown() async {
    // for (var i = seconds; i > 0; i--) {
    while (seconds > 0) await decreaseSeconds();
    // return seconds;
    // }
  }

  void reset() {
    seconds = 5;
    secondsSink.add(seconds);
    countDown();
  }

  void dispose() {
    _secondsStreamController.close();
  }
}
