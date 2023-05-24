import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/chat_message.dart';
import '../../providers.dart';

class ChatPage extends ConsumerWidget {
  final String groupName;

  final TextEditingController textEditingController = TextEditingController();

  ChatPage({Key? key, required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Consumer(
              builder: (context, watch, _) {
                final chatMessages = ref.watch(chatMessagesProvider);

                return ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatMessages[index];

                    return ListTile(
                      title: Text(message.sender),
                      subtitle: Text(message.message),
                      trailing: const Text(
                          'Timestamp'), // Replace with actual timestamp
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Type a message',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Send the message logic

                  final message = textEditingController.text.trim();
                  if (message.isNotEmpty) {
                    // Get the current chat messages from the provider
                    final chatMessages =
                        ref.read(chatMessagesProvider.notifier).state;

                    // Create a new message object
                    final newMessage = ChatMessage(
                      sender: 'You', // Replace with actual sender name
                      message: message,
                      timestamp:
                          DateTime.now(), // Replace with actual timestamp
                    );

                    // Update the chat messages state with the new message
                    ref.read(chatMessagesProvider.notifier).state = [
                      ...chatMessages,
                      newMessage
                    ];

                    // Close the dialog
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
