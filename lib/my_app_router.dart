import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/screens/chat/otp.dart';
import 'package:ichat/screens/home.dart';
import 'package:ichat/screens/login.dart';
import 'screens/chat/chat_page.dart';
import 'screens/chat/group_name.dart';
import 'screens/chat/select_contacts.dart';

class MyAppRouter {
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          // Check if the user is logged in
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // User is logged in, navigate to the home page
            return const MaterialPage<void>(
              child: HomePage(),
            );
          } else {
            // User is not logged in, navigate to the login page
            return MaterialPage<void>(
              child: LoginPage(),
            );
          }
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
        path: '/otp_verification',
        pageBuilder: (context, state) {
          // Extract the verification ID from the query parameters
          final verificationId = state.queryParameters['verificationId'] ?? '';

          return MaterialPage<void>(
            child: OTPVerificationPage(verificationId: verificationId),
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
