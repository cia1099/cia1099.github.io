import 'dart:math';

import 'package:dice3d/dice3d.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_furious/fast_furious.dart';
import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';
import 'package:slot_machine_roller/slot_machine_roller.dart';

Widget createRoulette([Duration period = const Duration(seconds: 7)]) {
  final rng = Random();
  return LayoutBuilder(
    builder: (context, constraints) => StreamBuilder(
      initialData: 0,
      stream:
          //Stream.periodic(period, (_) => rng.nextInt(37))
          () async* {
        yield 0;
        await Future.delayed(
            Duration(milliseconds: period.inMilliseconds ~/ 10));
        yield rng.nextInt(37);
        yield* Stream.periodic(
            Duration(
                milliseconds:
                    period.inMilliseconds + period.inMilliseconds ~/ 10),
            (_) => rng.nextInt(37));
      }(),
      builder: (context, snapshot) => RouletteAnimation(
          duration: Duration(seconds: period.inSeconds - 2),
          diameter: constraints.maxHeight * 0.9,
          targetNumber: snapshot.data!),
    ),
  );
}

Widget createSlotMachine(Duration period) {
  final rng = Random();
  return StreamBuilder(
    initialData: List.generate(3, (index) => rng.nextInt(6) + 1),
    stream: () async* {
      yield List.generate(3, (index) => rng.nextInt(6) + 1);
      final halfPeriod = Duration(milliseconds: period.inMilliseconds ~/ 2);
      while (true) {
        yield List.filled(3, null);
        await Future.delayed(halfPeriod);
        yield List.generate(3, (index) => rng.nextInt(6) + 1);
        await Future.delayed(halfPeriod);
      }
    }(),
    builder: (context, snapshot) => SlotMachine(targets: snapshot.data!),
  );
}

Widget createDice(Duration period, BuildContext ctx) {
  final rng = Random();
  final length = ctx.locale.languageCode == 'en' ? 5 : 3;
  return StreamBuilder(
    key: Key(ctx.locale.languageCode),
    initialData: List.generate(length, (index) => rng.nextInt(6) + 1),
    stream: Stream.periodic(
        period, (_) => List.generate(length, (index) => rng.nextInt(6) + 1)),
    builder: (context, snapshot) => Dice3D(
      duration: Duration(seconds: 2),
      points: snapshot.data!,
    ),
  );
}

Widget createFastFurious(Duration period) {
  List<int>? numbers;
  final dataMap = _shuffleCar();
  var sampleY = dataMap["sampleY"];
  var shuffleCarImg = dataMap["shuffleCarImg"];
  return LayoutBuilder(
    builder: (context, constraints) => StreamBuilder(
      initialData: period.inSeconds,
      stream: () async* {
        // yield period.inSeconds;
        while (true) {
          for (int i = period.inSeconds; i > -1; i--) {
            yield i;
            await Future.delayed(Duration(seconds: 1));
          }
          numbers = List.generate(10, (index) => index + 1);
          yield 0;
          await Future.delayed(Duration(milliseconds: 1500));
          numbers = null;
          final dataMap = _shuffleCar();
          sampleY = dataMap["sampleY"];
          shuffleCarImg = dataMap["shuffleCarImg"];
          yield period.inSeconds;
        }
      }(),
      builder: (context, snapshot) => Stack(
        children: [
          Center(
            child: FastFuriousAnimation(
              leavedTime: snapshot.data!,
              sampleY: sampleY!,
              shuffleCarImg: shuffleCarImg!,
              size: Size(constraints.maxWidth, constraints.maxHeight / 2),
              numbers: numbers,
              duration: period,
            ),
          ),
          Offstage(
            offstage: snapshot.data == 0,
            child: Align(
              alignment: FractionalOffset(0.5, 0.85),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 96, color: Colors.greenAccent),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Map<String, List<int>> _shuffleCar() {
  final rng = Random();
  final set = <int>{};
  while (set.length < 10) {
    set.add(rng.nextInt(10));
  }
  final shuffleCarImg = set.toList();
  set.clear();
  while (set.length < 4) {
    set.add(rng.nextInt(4));
  }
  final sampleY =
      set.toList() + set.toList() + [set.elementAt(0), set.elementAt(1)];
  return {"shuffleCarImg": shuffleCarImg, "sampleY": sampleY};
}
