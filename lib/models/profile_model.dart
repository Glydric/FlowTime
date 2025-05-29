import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flowtime/services/storage_manager.dart';

class Profile {
  String name;
  Color color;
  int totalSeconds;
  int totalSessions;

  Profile({
    required this.name,
    required this.color,
    this.totalSeconds = 0,
    this.totalSessions = 0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'color': color.value,
    'totalSeconds': totalSeconds,
    'totalSessions': totalSessions,
  };

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json['name'],
    color: Color(json['color']),
    totalSeconds: json['totalSeconds'] ?? 0,
    totalSessions: json['totalSessions'] ?? 0,
  );

  void addSession(int seconds) {
    totalSeconds += seconds;
    totalSessions++;
  }
}

class ProfilesProvider extends ChangeNotifier {
  List<Profile> _profiles = [];
  int _selectedProfileIndex = 0;

  ProfilesProvider() {
    _loadProfiles();
  }

  List<Profile> get profiles => _profiles;

  Profile get selectedProfile => _profiles.isNotEmpty
      ? _profiles[_selectedProfileIndex]
      : _newDefault();

  int get selectedProfileIndex => _selectedProfileIndex;

  Future<void> _loadProfiles() async {
    final profilesJson = await StorageManager.getProfiles();
    if (profilesJson != null && profilesJson.isNotEmpty) {
      _profiles = List<Profile>.from(
        jsonDecode(profilesJson).map((x) => Profile.fromJson(x)),
      );
    } else {
      _profiles = [_newDefault()];
    }

    final selectedIndex = await StorageManager.getSelectedProfileIndex();
    if (selectedIndex != null && selectedIndex < _profiles.length) {
      _selectedProfileIndex = selectedIndex;
    }

    notifyListeners();
  }

  Future<void> saveProfiles() async {
    final profilesJson = jsonEncode(_profiles.map((p) => p.toJson()).toList());
    await StorageManager.saveProfiles(profilesJson);
    await StorageManager.saveSelectedProfileIndex(_selectedProfileIndex);
  }

  void selectProfile(Profile profile) =>
      selectProfileByIndex(profiles.indexOf(profile));

  void selectProfileByIndex(int index) {
    if (index >= 0 && index < _profiles.length) {
      _selectedProfileIndex = index;
      saveProfiles();
      notifyListeners();
    }
  }

  void addProfile(Profile profile) {
    _profiles.add(profile);
    saveProfiles();
    notifyListeners();
  }

  void updateProfile(int index, Profile profile) {
    if (index >= 0 && index < _profiles.length) {
      _profiles[index] = profile;
      saveProfiles();
      notifyListeners();
    }
  }

  void deleteProfile(int index) {
    if (index >= 0 && index < _profiles.length) {
      _profiles.removeAt(index);
      if (_selectedProfileIndex >= _profiles.length) {
        _selectedProfileIndex = _profiles.length - 1;
      }
      if (_profiles.isEmpty) {
        _profiles.add(_newDefault());
        _selectedProfileIndex = 0;
      }
      saveProfiles();
      notifyListeners();
    }
  }

  void addSessionToSelectedProfile(int seconds) {
    selectedProfile.addSession(seconds);
    saveProfiles();
    notifyListeners();
  }

  Profile _newDefault() {
    return Profile(name: 'Default', color: Colors.blue);
  }
}
