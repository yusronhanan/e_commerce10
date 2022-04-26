import 'package:e_commerce10/app/auth_widget.dart';
import 'package:e_commerce10/app/pages/auth/sign_in_page.dart';
import 'package:e_commerce10/app/providers.dart';
import 'package:e_commerce10/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWidget(
          nonSignedInBuilder: (context) => const Scaffold(
            body: SignInPage(),
          ),
          signedInBuilder: (context) => Scaffold(
            body: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Signed In in"),
                ElevatedButton(
                    onPressed: () {
                      ref.read(firebaseAuthProvider).signOut();
                    },
                    child: const Text("Sign out"))
              ],
            )),
          ),
        ));
  }
}
