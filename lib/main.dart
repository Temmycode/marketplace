import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/services/auth_service.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/utils/helpers/system_snackbar.dart';
import 'package:marketplace/views/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
      ),
      home: Consumer(builder: (context, ref, child) {
        ref.listen(
          authStateProvider,
          (_, authState) {
            if (authState.result == AuthResult.failure) {
              systemSnackBar(context, AuthService.error);
            }
          },
        );
        return const HomePage();
      }),
    );
  }
}
