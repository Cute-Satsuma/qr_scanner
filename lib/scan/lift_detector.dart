import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Whether the phone is currently being held or is resting on a surface.
enum HoldingState { holding, resting }

/// Turns raw accelerometer samples into a coarse "held vs resting" signal.
///
/// The detector uses the gravity-removed accelerometer (user acceleration) so
/// that a phone lying flat on a table produces readings close to zero, while a
/// phone being picked up or handled produces a visible spike. The decision is
/// made lazily on every sample using timestamps, so it never leaves pending
/// timers behind.
class LiftDetector extends ChangeNotifier {
  LiftDetector({
    this.moveThreshold = 0.45,
    this.restAfter = const Duration(seconds: 3),
    this.holdAfter = const Duration(milliseconds: 400),
    this.calibrateFor = const Duration(milliseconds: 1500),
    this.sampleStream,
  });

  /// Magnitude of user acceleration (m/s^2) considered "moving".
  final double moveThreshold;

  /// How long the phone must stay still before it counts as resting.
  final Duration restAfter;

  /// How long movement must be sustained before it counts as held again.
  final Duration holdAfter;

  /// Startup window during which the detector decides the initial state.
  ///
  /// If no movement is seen during this window, the phone is assumed to be
  /// resting; otherwise it starts as held.
  final Duration calibrateFor;

  /// Optional stream override, mainly for tests. Defaults to the real
  /// accelerometer stream.
  final Stream<UserAccelerometerEvent>? sampleStream;

  StreamSubscription<UserAccelerometerEvent>? _subscription;

  HoldingState _state = HoldingState.holding;
  HoldingState get state => _state;

  DateTime? _startedAt;
  DateTime? _lastMoveAt;
  DateTime? _moveBeganAt;

  /// Begin listening to the accelerometer.
  void start() {
    if (_subscription != null) return;

    _startedAt = null;
    _lastMoveAt = null;
    _moveBeganAt = null;
    _setState(HoldingState.holding);

    final stream = sampleStream ??
        userAccelerometerEventStream(
          samplingPeriod: SensorInterval.normalInterval,
        );
    _subscription = stream.listen(
      _onSample,
      // Missing plugin in widget tests, or unsupported hardware.
      onError: (Object error, StackTrace stackTrace) {},
    );
  }

  void _onSample(UserAccelerometerEvent event) {
    final now = event.timestamp;
    final startedAt = _startedAt ??= now;
    final magnitude =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    final moving = magnitude >= moveThreshold;

    if (moving) {
      _lastMoveAt = now;
      _moveBeganAt ??= now;
    } else {
      _moveBeganAt = null;
    }

    // During the startup calibration window we stay in the default "holding"
    // state and only decide on the first sample after it ends.
    if (now.difference(startedAt) < calibrateFor) return;

    if (_state == HoldingState.holding) {
      final lastMove = _lastMoveAt;
      if (lastMove == null || now.difference(lastMove) >= restAfter) {
        _setState(HoldingState.resting);
      }
    } else {
      final moveBegan = _moveBeganAt;
      if (moveBegan != null && now.difference(moveBegan) >= holdAfter) {
        _setState(HoldingState.holding);
      }
    }
  }

  void _setState(HoldingState next) {
    if (_state == next) return;
    _state = next;
    notifyListeners();
  }

  /// Stop listening to the accelerometer.
  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
