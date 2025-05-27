import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flowtime/models/profile_model.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profilesProvider = Provider.of<ProfilesProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddEditProfileDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: profilesProvider.profiles.length,
        itemBuilder: (context, index) {
          final profile = profilesProvider.profiles[index];
          final isSelected = index == profilesProvider.selectedProfileIndex;
          
          return Card(
            elevation: isSelected ? 4 : 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isSelected 
                  ? BorderSide(color: profile.color, width: 2)
                  : BorderSide.none,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: profile.color,
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(
                profile.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Sessions: ${profile.totalSessions}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    'Total time: ${_formatTotalTime(profile.totalSeconds)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    const Icon(Icons.check_circle, color: Colors.green),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showAddEditProfileDialog(context, profile: profile, index: index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmation(context, index);
                    },
                  ),
                ],
              ),
              onTap: () {
                profilesProvider.selectProfileByIndex(index);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }

  String _formatTotalTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    
    if (hours > 0) {
      return '$hours h ${minutes.toString().padLeft(2, '0')} min';
    } else {
      return '$minutes min';
    }
  }

  void _showAddEditProfileDialog(
    BuildContext context, {
    Profile? profile,
    int? index,
  }) {
    showDialog(
      context: context,
      builder: (context) => ProfileDialog(
        profile: profile,
        index: index,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    final profilesProvider = Provider.of<ProfilesProvider>(context, listen: false);
    final profile = profilesProvider.profiles[index];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile'),
        content: Text('Are you sure you want to delete "${profile.name}"?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              profilesProvider.deleteProfile(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileDialog extends StatefulWidget {
  final Profile? profile;
  final int? index;
  
  const ProfileDialog({
    super.key,
    this.profile,
    this.index,
  });

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late TextEditingController _nameController;
  late Color _selectedColor;
  
  final List<Color> _colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile?.name ?? '');
    _selectedColor = widget.profile?.color ?? _colorOptions[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.profile != null;
    
    return AlertDialog(
      title: Text(isEditing ? 'Edit Profile' : 'New Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Profile Name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 24),
          const Text('Select Color'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _colorOptions.map((color) {
              final isSelected = _selectedColor.value == color.value;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: color.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ]
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(isEditing ? 'Update' : 'Create'),
          onPressed: () {
            final name = _nameController.text.trim();
            if (name.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a profile name')),
              );
              return;
            }
            
            final profilesProvider = Provider.of<ProfilesProvider>(context, listen: false);
            
            if (isEditing) {
              final updatedProfile = Profile(
                name: name,
                color: _selectedColor,
                totalSeconds: widget.profile!.totalSeconds,
                totalSessions: widget.profile!.totalSessions,
              );
              profilesProvider.updateProfile(widget.index!, updatedProfile);
            } else {
              final newProfile = Profile(
                name: name,
                color: _selectedColor,
              );
              profilesProvider.addProfile(newProfile);
            }
            
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}