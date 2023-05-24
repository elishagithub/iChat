import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/screens/home.dart';
import 'package:ichat/screens/login.dart';
import 'screens/chat/chat_page.dart';
import 'screens/chat/group_name.dart';
import 'screens/chat/select_contacts.dart';

class MyAppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) {
      //     // Check if the user is logged in
      //     final user = FirebaseAuth.instance.currentUser;
      //     if (user != null) {
      //       // User is logged in, navigate to the home page
      //       return const MaterialPage<void>(
      //         child: HomePage(),
      //       );
      //     } else {
      //       // User is not logged in, navigate to the login page
      //       return const MaterialPage<void>(
      //         child: LoginPage(),
      //       );
      //     }
      //   },
      // ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage<void>(child: HomePage());
        },
      ),
      GoRoute(
        path: '/chat/:groupName',
        pageBuilder: (context, state) {
          // Extract the group name from the path parameters
          final groupName = state.pathParameters['groupName'] ?? '';

          return MaterialPage<void>(
            child: ChatPage(groupName: groupName),
          );
        },
      ),
      GoRoute(
        path: '/select_contacts',
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: SelectContactsPage(),
        ),
      ),
      GoRoute(
        path: '/group_name',
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: GroupNamePage(),
        ),
      ),
    ],
  );
}
