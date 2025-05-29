import 'dart:async';
import 'dart:math' show min;
import 'package:flowtime/models/clock_model.dart' show ClockModel;
import 'package:flutter/foundation.dart';

enum RelaxState { idle, running, paused, finished }

class RelaxModel extends ChangeNotifier {
  final int _originalSeconds;
  int _remainingSeconds;
  Timer? _timer;

  RelaxModel.fromClockModel(ClockModel clockModel)
    : _originalSeconds = (clockModel.elapsedSeconds * 0.2).round(),
      _remainingSeconds = (clockModel.elapsedSeconds * 0.2).round();

  bool get isRunning => _timer?.isActive ?? false;

  int get remainingSeconds => min(_originalSeconds, _remainingSeconds);

  String get formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final remainingSeconds = _remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get formattedTotalTime {
    final minutes = _originalSeconds ~/ 60;
    final remainingSeconds = _originalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get formattedRemainingTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void start() {
    if (isRunning) return;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
      } else {
        _remainingSeconds--;
      }

      if (isRunning) notifyListeners();
    });
  }
}
