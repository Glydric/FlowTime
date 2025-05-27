import 'dart:developer' show log;

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
          _buildProfileSelector(
            context,
            Provider.of<ProfilesProvider>(context),
          ),
          _buildClock(context),
          _buildControls(context, Provider.of<ClockModel>(context)),
        ],
      ),
    ),
  );

  Widget _buildProfileSelector(
    BuildContext context,
    ProfilesProvider profilesProvider,
  ) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      DropdownMenu<Profile>(
        // todo make the user lose focus when clicking outside the dropdown (and perform a profile == null)e
        width: 160,
        enableSearch: false,
        // enableFilter: true,
        initialSelection: profilesProvider.selectedProfile,
        onSelected: (Profile? profile) {
          if (profile != null) {
            profilesProvider.selectProfile(profile);
          } else {
            profilesProvider.refreshProfiles();
          }
        },
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: profilesProvider.selectedProfile.color.withOpacity(0.2),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: profilesProvider.selectedProfile.color,
        ),
        leadingIcon: Icon(
          Icons.circle,
          color: profilesProvider.selectedProfile.color,
          size: 16,
        ),
        dropdownMenuEntries: profilesProvider.profiles
            .map(
              (profile) => DropdownMenuEntry<Profile>(
                value: profile,
                label: profile.name,
                leadingIcon: Icon(Icons.circle, color: profile.color, size: 16),
              ),
            )
            .toList(),
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

  Widget _buildClock(BuildContext context) {
    final clockModel = Provider.of<ClockModel>(context);

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

  Widget _buildControls(BuildContext context, ClockModel clockModel) =>
      !clockModel.isRunning
      ? ElevatedButton.icon(
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start'),
          onPressed: clockModel.start,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        )
      : Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.stop),
            label: const Text('Take a Break'),
            onPressed: () => _finishSession(context, clockModel),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
          ),
        );

  Future<void> _finishSession(
    BuildContext context,
    ClockModel clockModel,
  ) async {
    final profilesProvider = Provider.of<ProfilesProvider>(context);
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
    //   after break concluded, reset clock
    clockModel.reset();
  }
}
