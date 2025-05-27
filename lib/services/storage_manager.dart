import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String profilesKey = 'profiles';
  static const String selectedProfileIndexKey = 'selected_profile_index';
  static const String settingsKey = 'settings';
  static const String _themeKey = 'theme';

  static final _prefs = SharedPreferencesAsync();

  static Future<String?> getProfiles() async {
    return await _prefs.getString(profilesKey);
  }

  static Future<void> saveProfiles(String profilesJson) async {
    await _prefs.setString(profilesKey, profilesJson);
  }

  static Future<int?> getSelectedProfileIndex() async {
    return await _prefs.getInt(selectedProfileIndexKey);
  }

  static Future<void> saveSelectedProfileIndex(int index) async {
    await _prefs.setInt(selectedProfileIndexKey, index);
  }

  static Future<String?> getSettings() async {
    return await _prefs.getString(settingsKey);
  }

  static Future<void> saveSettings(String settingsJson) async {
    await _prefs.setString(settingsKey, settingsJson);
  }

  static Future<String> getTheme() async {
    return await _prefs.getString(_themeKey) ?? 'system';
  }
}
