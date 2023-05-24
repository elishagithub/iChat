import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Message',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to select contacts page
              context.go('/select_contacts');
            },
            child: const Text('Select Contacts'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer(
              builder: (context, watch, _) {
                final selectedContacts = ref.watch(selectedContactsProvider);
                final groupName = ref.watch(groupNameProvider);
                final loading = ref.watch(loadingProvider);

                if (selectedContacts.isEmpty) {
                  return const Center(
                    child: Text('No contacts selected'),
                  );
                }

                if (loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: 1, // Change this to the number of groups/users
                  itemBuilder: (context, index) {
                    final chatMessages = ref.watch(chatMessagesProvider);
                    final lastMessage = chatMessages.isNotEmpty
                        ? chatMessages.last.message
                        : '';

                    // Replace the following with your logic to display group name or user name
                    final name = groupName.isNotEmpty
                        ? groupName
                        : selectedContacts[index];

                    return ListTile(
                      leading: CircleAvatar(
                        // Replace with your logic to display group photo or user photo
                        child: Text(name[0]),
                      ),
                      title: Text(name),
                      subtitle: Text(lastMessage),
                      trailing: const Text(
                          'Timestamp'), // Replace with actual timestamp
                      onTap: () {
                        // Navigate to chat page for the selected group/user
                        context.go('/chat/$name');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
