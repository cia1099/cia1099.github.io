import 'package:flutter_test/flutter_test.dart';

import 'package:roulette/roulette.dart';

void main() {
  group('Whether _originIndex is correct?', () {
    test('accumulation index', () {
      final sum = List.generate(37, (i) => i)
          .fold(0, (previousValue, element) => previousValue + element);
      expect(accumulateIndex(), sum);
    });

    test('maximum number must be 36', () => expect(maxNumber(), 36));

    test('there is 37 interval', () => expect(numberLength(), 37));
  });
}
