import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flowtime/models/relax_model.dart';
import 'package:audioplayers/audioplayers.dart';

class RelaxScreen extends StatefulWidget {
  final RelaxModel relaxModel;

  const RelaxScreen({required this.relaxModel, super.key});

  @override
  State<RelaxScreen> createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    widget.relaxModel.addListener(_handleRelaxModelChange);
    widget.relaxModel.start();
  }

  void _handleRelaxModelChange() {
    log("relaxModel.remainingSeconds ${widget.relaxModel.remainingSeconds}");
    if (widget.relaxModel.remainingSeconds == 0) {
      _audioPlayer.play(AssetSource('audio/audio.wav'));
    }
  }

  @override
  void dispose() {
    widget.relaxModel.removeListener(_handleRelaxModelChange);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Take a Break')),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Relax Time: ${widget.relaxModel.formattedTotalTime}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ListenableBuilder(
          listenable: widget.relaxModel,
          builder: (context, _) => Text(
            widget.relaxModel.formattedTime,
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Done'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildRelaxationTools(context),
      ],
    ),
  );

  Widget _buildRelaxationTools(BuildContext context) => Column(
    children: [
      const Text(
        'Relaxation Tools',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      _buildToolButton(context),
    ],
  );

  Widget _buildToolButton(BuildContext context) => Column(
    spacing: 8,
    children: [
      IconButton(
        icon: const Icon(Icons.self_improvement, size: 32),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const BreathingExerciseDialog(),
        ),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          padding: const EdgeInsets.all(16),
        ),
      ),
      const Text('Breathing Exercise', style: TextStyle(fontSize: 12)),
    ],
  );
}

class BreathingExerciseDialog extends StatefulWidget {
  const BreathingExerciseDialog({super.key});

  @override
  State<BreathingExerciseDialog> createState() =>
      _BreathingExerciseDialogState();
}

class _BreathingExerciseDialogState extends State<BreathingExerciseDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _instruction = "Breathe in...";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _instruction = "Breathe out...";
        });
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _instruction = "Breathe in...";
        });
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('4-7-8 Breathing Exercise'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Breathe in for 4 seconds, hold for 7 seconds, exhale for 8 seconds.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
            child: Center(
              child: Container(
                width: 100 * _animation.value,
                height: 100 * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(_instruction),
      ],
    ),
    actions: [
      TextButton(
        child: const Text('Close'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}