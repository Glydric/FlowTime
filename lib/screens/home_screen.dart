import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flowtime/models/clock_model.dart';
import 'package:flowtime/models/profile_model.dart';
import 'package:flowtime/models/relax_model.dart';
import 'package:flowtime/screens/relax_screen.dart';
import 'package:flowtime/screens/settings_screen.dart';
import 'package:flowtime/screens/profiles_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('FlowTime'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 40,
        children: [
          _buildProfileSelector(context),
          _buildClock(context),
          _buildControls(context),
        ],
      ),
    ),
  );

  Widget _buildProfileSelector(BuildContext context) {
    final ProfilesProvider profilesProvider = Provider.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PopupMenuButton<Profile>(
          initialValue: profilesProvider.selectedProfile,
          onSelected: profilesProvider.selectProfile,
          itemBuilder: (BuildContext context) => profilesProvider.profiles
              .map(
                (profile) => PopupMenuItem<Profile>(
                  value: profile,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: profile.color, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontWeight:
                              profile == profilesProvider.selectedProfile
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: profilesProvider.selectedProfile.color.withAlpha(51),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  color: profilesProvider.selectedProfile.color,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  profilesProvider.selectedProfile.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: profilesProvider.selectedProfile.color,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilesScreen()),
          ),
          tooltip: 'Edit Profiles',
        ),
      ],
    );
  }

  Widget _buildClock(BuildContext context) {
    final ClockModel clockModel = Provider.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            clockModel.formattedTime,
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            clockModel.isRunning ? 'Focus time' : 'Ready to start',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    final ClockModel clockModel = Provider.of(context);
    return !clockModel.isRunning
        ? ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start'),
            onPressed: clockModel.start,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        : ElevatedButton.icon(
            icon: const Icon(Icons.stop),
            label: const Text('Take a Break'),
            onPressed: () => _finishSession(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
          );
  }

  Future<void> _finishSession(BuildContext context) async {
    final ClockModel clockModel = Provider.of(context, listen: false);
    if (clockModel.elapsedSeconds == 0) return;

    final ProfilesProvider profilesProvider = Provider.of(
      context,
      listen: false,
    );
    profilesProvider.addSessionToSelectedProfile(clockModel.elapsedSeconds);

    clockModel.finish();

    // Navigate to relax screen
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RelaxScreen(relaxModel: RelaxModel.fromClockModel(clockModel)),
      ),
    );
    // after break concluded, reset clock
    clockModel.reset();
  }
}
