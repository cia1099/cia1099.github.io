library roulette;

import 'dart:math' as math;

import 'package:flutter/material.dart';

part 'painter/ball_painter.dart';
part 'widget/roulette_animation.dart';
part 'painter/sector_painter.dart';

final _locationThetas = List.generate(
    37, (i) => -math.pi / 2 + i * math.pi * 2 / 37,
    growable: false);

const _originIndex = <int>[
  0,
  32,
  15,
  19,
  4,
  21,
  2,
  25,
  17,
  34,
  6,
  27,
  13,
  36,
  11,
  30,
  8,
  23,
  10,
  5,
  24,
  16,
  33,
  1,
  20,
  14,
  31,
  9,
  22,
  18,
  29,
  7,
  28,
  12,
  35,
  3,
  26,
];

int accumulateIndex() =>
    _originIndex.fold(0, (previousValue, element) => previousValue + element);

int maxNumber() =>
    _originIndex.reduce((value, element) => math.max(value, element));

int numberLength() => _originIndex.length;
