import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/providers.dart';
import 'package:ichat/screens/chat/chat_page.dart';
import 'package:ichat/screens/chat/group_name.dart';
import 'package:ichat/screens/chat/otp.dart';
import 'package:ichat/screens/chat/select_contacts.dart';
import 'package:ichat/screens/home.dart';
import 'package:ichat/screens/login.dart';
import 'connection_manager.dart';
import 'firebase_options.dart';
import 'my_app_theme.dart';

// GoRouter configuration
final _router = GoRouter(
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
          return const MaterialPage<void>(
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  final ConnectionManager _connectionManager = ConnectionManager();

  @override
  void dispose() {
    _connectionManager.unsubscribeFromConnectionChanges();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingProvider);

    return MaterialApp.router(
      title: 'iChat',
      theme: MyAppTheme.themeData,
      routerConfig: _router,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            loading == true
                ? Container(
                    color: const Color.fromARGB(136, 122, 122, 122),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyAppTheme.themeData.colorScheme.primary,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
