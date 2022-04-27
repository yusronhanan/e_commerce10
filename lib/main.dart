import 'package:e_commerce10/app/auth_widget.dart';
import 'package:e_commerce10/app/pages/admin/admin_home.dart';
import 'package:e_commerce10/app/pages/auth/sign_in_page.dart';
import 'package:e_commerce10/app/providers.dart';
import 'package:e_commerce10/firebase_options.dart';
import 'package:e_commerce10/pages/user/user_home.dart';
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
            colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        )),
        home: AuthWidget(
          nonSignedInBuilder: (context) => const Scaffold(
            body: SignInPage(),
          ),
          signedInBuilder: (context) => const UserHome(),
          adminSignedInBuilder: (BuildContext context) => const AdminHome(),
        ));
  }
}
