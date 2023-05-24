import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers.dart';

class GroupNamePage extends ConsumerWidget {
  const GroupNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController groupNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Name'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: groupNameController,
            decoration: const InputDecoration(
              labelText: 'Group Name',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Set the group name
              final groupName = groupNameController.text.trim();
              if (groupName.isNotEmpty) {
                ref.read(groupNameProvider.notifier).state = groupName;
              }

              // Navigate back to home
              context.go('/');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
