import 'package:flowtime/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _startOnBoot = false;
  String _selectedTheme = 'system';

  late final _themeProvider = Provider.of<ThemeProvider>(
    context,
    listen: false,
  );

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _soundEnabled = prefs.getBool('sound_enabled') ?? true;
      _startOnBoot = prefs.getBool('start_on_boot') ?? false;
      _selectedTheme = prefs.getString('theme') ?? "system";
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('sound_enabled', _soundEnabled);
    await prefs.setBool('start_on_boot', _startOnBoot);
    await prefs.setString('theme', _selectedTheme);

    _themeProvider.setTheme(_selectedTheme);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Notifications'),
        SwitchListTile(
          title: const Text('Enable Notifications'),
          subtitle: const Text('Get notified when your timer ends'),
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
            _saveSettings();
            _updateNotificationSettings(value);
          },
        ),
        SwitchListTile(
          title: const Text('Sound'),
          subtitle: const Text('Play sound when timer ends'),
          value: _soundEnabled,
          onChanged: (value) {
            setState(() {
              _soundEnabled = value;
            });
            _saveSettings();
          },
        ),
        const Divider(),
        _buildSectionHeader('Appearance'),
        _buildThemeSelector(),
        const Divider(),
        _buildSectionHeader('System'),
        SwitchListTile(
          title: const Text('Start on Boot'),
          subtitle: const Text('Launch FlowTime when your device starts'),
          value: _startOnBoot,
          onChanged: (value) {
            setState(() {
              _startOnBoot = value;
            });
            _saveSettings();
          },
        ),
        const Divider(),
        _buildSectionHeader('About'),
        ListTile(
          title: const Text('Version'),
          subtitle: const Text('1.0.0'),
          trailing: const Icon(Icons.info_outline),
          onTap: _showAboutDialog,
        ),
      ],
    ),
  );

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );

  Widget _buildThemeSelector() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text('Theme'),
      ),
      RadioListTile<String>(
        title: const Text('System Default'),
        value: 'system',
        groupValue: _selectedTheme,
        onChanged: (value) {
          setState(() {
            _selectedTheme = value!;
          });
          _saveSettings();
        },
      ),
      RadioListTile<String>(
        title: const Text('Light'),
        value: 'light',
        groupValue: _selectedTheme,
        onChanged: (value) {
          setState(() {
            _selectedTheme = value!;
          });
          _saveSettings();
        },
      ),
      RadioListTile<String>(
        title: const Text('Dark'),
        value: 'dark',
        groupValue: _selectedTheme,
        onChanged: (value) {
          setState(() {
            _selectedTheme = value!;
          });
          _saveSettings();
        },
      ),
    ],
  );

  Future<void> _updateNotificationSettings(bool enabled) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (enabled) {
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      const iosSettings = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await flutterLocalNotificationsPlugin.initialize(initSettings);
    }
  }

  void _showAboutDialog() => showAboutDialog(
    context: context,
    applicationName: 'FlowTime',
    applicationVersion: '1.0.0',
    applicationIcon: Image.asset(
      'assets/icons/logo.png',
      width: 48,
      height: 48,
    ),
    applicationLegalese: '© 2025 Glydric',
    children: [
      const SizedBox(height: 16),
      const Text(
        'FlowTime is an application designed to implement the FlowTime technique, '
        'which is a variant of the Pomodoro Timer. It helps users maintain their '
        'productive flow by providing a timer that allows short breaks after focused work periods.',
      ),
    ],
  );
}
