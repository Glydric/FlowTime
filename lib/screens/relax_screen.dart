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
    widget.relaxModel.addListener(() {
      log("relaxModel.totalRelaxSeconds ${widget.relaxModel.elapsedSeconds}");
      if (widget.relaxModel.elapsedSeconds == 0) {
        _audioPlayer.play(AssetSource('audio/audio.wav'));
      }
    });
    widget.relaxModel.start();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Take a Break')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Relax Time',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Suggested break: ${widget.relaxModel.formattedTotalTime}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            widget.relaxModel.formattedTime,
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          if (widget.relaxModel.isTimeUp)
            const Text(
              'Break time is up!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.relaxModel.isRunning)
                ElevatedButton.icon(
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                  onPressed: () {
                    widget.relaxModel.pause();
                  },
                ),
              if (!widget.relaxModel.isRunning)
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Resume'),
                  onPressed: widget.relaxModel.start,
                ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Done'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildRelaxationTools(),
        ],
      ),
    ),
  );

  Widget _buildRelaxationTools() => Column(
    children: [
      const Text(
        'Relaxation Tools',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      _buildToolButton(
        icon: Icons.self_improvement,
        label: 'Breathing Exercise',
        onPressed: _showBreathingExercise,
      ),
    ],
  );

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) => Column(
    children: [
      IconButton(
        icon: Icon(
          icon,
          color: isActive ? Theme.of(context).colorScheme.primary : null,
          size: 32,
        ),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: isActive
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.surfaceVariant,
          padding: const EdgeInsets.all(16),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
    ],
  );

  void _showBreathingExercise() {
    showDialog(
      context: context,
      builder: (context) => const BreathingExerciseDialog(),
    );
  }
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
  Widget build(BuildContext context) {
    return AlertDialog(
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
            builder: (context, child) {
              return Container(
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
              );
            },
          ),
          const SizedBox(height: 16),
          Text(_instruction),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
