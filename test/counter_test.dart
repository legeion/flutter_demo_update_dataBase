// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:flutter_demo_update_db/counter.dart';

/// Documentation de référence :
/// - [Testing Flutter apps](https://docs.flutter.dev/testing)
void main() {
  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
