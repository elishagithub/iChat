import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_manager.dart';
import 'api_provider.dart';
import 'common/snacker.dart';
import 'models/chat_message.dart';

final apiManagerProvider = Provider((ref) => ApiManager(
      dio: ApiProvider().dio!,
      prefs: ApiProvider().sharedPreferences!,
    ));

final sharedPreferencesProvider =
    Provider((ref) => ApiProvider().sharedPreferences!);

final loadingProvider = StateProvider<bool>((ref) => false);

final snackerProvider = StateProvider<Snacker>((ref) => Snacker());

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// Provider to manage the selected contacts
final selectedContactsProvider = StateProvider<List<String>>((ref) => []);

// Provider to manage the group name
final groupNameProvider = StateProvider<String>((ref) => '');

// Provider to manage the chat messages
final chatMessagesProvider = StateProvider<List<ChatMessage>>((ref) => [
      ChatMessage(
        sender: 'John Doe',
        message: 'Hello!',
        timestamp: DateTime.now(),
      ),
    ]);
