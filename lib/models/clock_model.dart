import 'dart:async';
import 'package:flutter/foundation.dart';

class ClockModel extends ChangeNotifier {
  int _elapsedSeconds = 0;
  Timer? _timer;

  bool get isRunning => _timer?.isActive ?? false;

  int get elapsedSeconds => _elapsedSeconds;

  String get formattedTime {
    final hours = _elapsedSeconds ~/ 3600;
    final minutes = (_elapsedSeconds % 3600) ~/ 60;
    final remainingSeconds = _elapsedSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void start() {
    _elapsedSeconds = 0;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
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

  void reset() {
    _elapsedSeconds = 0;
    _timer?.cancel();
    notifyListeners();
  }
}
