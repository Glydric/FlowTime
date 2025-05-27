import 'dart:async';
import 'package:flowtime/models/clock_model.dart' show ClockModel;
import 'package:flutter/foundation.dart';

enum RelaxState { idle, running, paused, finished }

class RelaxModel extends ChangeNotifier {
  final int _originalSeconds;
  int _elapsedSeconds = 0;
  Timer? _timer;

  RelaxModel.fromClockModel(ClockModel clockModel)
    : _originalSeconds = (clockModel.elapsedSeconds * 0.2).round(),
      _elapsedSeconds = (clockModel.elapsedSeconds * 0.2).round();

  bool get isRunning => _timer?.isActive ?? false;

  bool get isTimeUp =>
      _elapsedSeconds >= _originalSeconds && _originalSeconds > 0;

  int get elapsedSeconds => _elapsedSeconds;

  String get formattedTime {
    final minutes = _elapsedSeconds ~/ 60;
    final remainingSeconds = _elapsedSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get formattedTotalTime {
    final minutes = _originalSeconds ~/ 60;
    final remainingSeconds = _originalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int get remainingSeconds => _originalSeconds > _elapsedSeconds
      ? _originalSeconds - _elapsedSeconds
      : 0;

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
    if (!isRunning) {
      _elapsedSeconds = 0;
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;

      if (isTimeUp && isRunning) {
        finish();
      }

      notifyListeners();
    });
    notifyListeners();
  }

  void pause() {
    if (isRunning) {
      _timer?.cancel();
      notifyListeners();
    }
  }

  void finish() {
    _timer?.cancel();
    notifyListeners();
  }
}
