import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ichat/my_app_router.dart';
import 'package:ichat/providers.dart';
import 'connection_manager.dart';
import 'firebase_options.dart';
import 'my_app_theme.dart';

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
      routerConfig: MyAppRouter.router,
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
