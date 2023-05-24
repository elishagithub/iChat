import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers.dart';

class SelectContactsPage extends ConsumerWidget {
  const SelectContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace this with your logic to select contacts
    final selectedContacts = ['John Doe', 'Jane Smith'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Selected Contacts: ${selectedContacts.length}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: selectedContacts.length,
              itemBuilder: (context, index) {
                final contact = selectedContacts[index];

                return ListTile(
                  title: Text(contact),
                  onTap: () {
                    // Remove the contact from selectedContacts
                    ref.read(selectedContactsProvider).remove(contact);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to group name page
          context.go('/group_name');
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
