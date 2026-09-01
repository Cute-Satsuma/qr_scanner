import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner/scan/lift_detector.dart';
import 'package:sensors_plus/sensors_plus.dart';

UserAccelerometerEvent _sample(
  double milliseconds, {
  double x = 0,
  double y = 0,
  double z = 0,
}) {
  return UserAccelerometerEvent(
    x,
    y,
    z,
    DateTime.fromMillisecondsSinceEpoch(milliseconds.toInt()),
  );
}

void main() {
  group('LiftDetector', () {
    test('rests when there is no movement during calibration', () {
      final controller = StreamController<UserAccelerometerEvent>(sync: true);
      final detector = LiftDetector(
        calibrateFor: const Duration(milliseconds: 100),
        sampleStream: controller.stream,
      );

      detector.start();
      expect(detector.state, HoldingState.holding);

      controller.add(_sample(0));
      controller.add(_sample(50));
      expect(detector.state, HoldingState.holding);

      controller.add(_sample(100));
      expect(detector.state, HoldingState.resting);

      detector.dispose();
      controller.close();
    });

    test('stays holding while the phone keeps moving', () {
      final controller = StreamController<UserAccelerometerEvent>(sync: true);
      final detector = LiftDetector(
        calibrateFor: const Duration(milliseconds: 100),
        restAfter: const Duration(seconds: 1),
        sampleStream: controller.stream,
      );

      detector.start();
      controller.add(_sample(0, x: 1));
      controller.add(_sample(100, x: 1));
      expect(detector.state, HoldingState.holding);

      controller.add(_sample(500));
      expect(detector.state, HoldingState.holding);

      detector.dispose();
      controller.close();
    });

    test('rests after the phone stays still for restAfter', () {
      final controller = StreamController<UserAccelerometerEvent>(sync: true);
      final detector = LiftDetector(
        calibrateFor: const Duration(milliseconds: 100),
        restAfter: const Duration(milliseconds: 1000),
        sampleStream: controller.stream,
      );

      detector.start();
      controller.add(_sample(0, x: 1));
      controller.add(_sample(200));
      expect(detector.state, HoldingState.holding);

      controller.add(_sample(1200));
      expect(detector.state, HoldingState.resting);

      detector.dispose();
      controller.close();
    });

    test('wakes back to holding after sustained movement', () {
      final controller = StreamController<UserAccelerometerEvent>(sync: true);
      final detector = LiftDetector(
        calibrateFor: const Duration(milliseconds: 100),
        holdAfter: const Duration(milliseconds: 100),
        sampleStream: controller.stream,
      );

      detector.start();
      controller.add(_sample(0));
      controller.add(_sample(100));
      expect(detector.state, HoldingState.resting);

      controller.add(_sample(200, x: 1));
      expect(detector.state, HoldingState.resting);

      controller.add(_sample(300, x: 1));
      expect(detector.state, HoldingState.holding);

      detector.dispose();
      controller.close();
    });

    test('notifies listeners when restarted after resting', () {
      final controller = StreamController<UserAccelerometerEvent>.broadcast(
        sync: true,
      );
      final detector = LiftDetector(
        calibrateFor: const Duration(milliseconds: 100),
        sampleStream: controller.stream,
      );
      var notified = 0;
      var holding = true;

      detector.addListener(() {
        notified += 1;
        holding = detector.state == HoldingState.holding;
      });

      detector.start();
      controller.add(_sample(0));
      controller.add(_sample(100));
      expect(detector.state, HoldingState.resting);
      expect(holding, isFalse);

      detector.stop();
      notified = 0;
      detector.start();
      expect(detector.state, HoldingState.holding);
      expect(holding, isTrue);
      expect(notified, 1);

      detector.dispose();
      controller.close();
    });
  });
}
