import 'package:e_commerce10/app/providers.dart';
import 'package:e_commerce10/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget(
      {Key? key,
      required this.signedInBuilder,
      required this.nonSignedInBuilder,
      required this.adminSignedInBuilder})
      : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  final adminEmail =
      "admin@admin.com"; // TODO: store this somewhere else on production

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);

    return authStateChanges.when(
      data: (user) => user != null
          ? signedInHandler(context, ref, user)
          : nonSignedInBuilder(context),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
          body: Center(
        child: Text("Something went wrong!"),
      )),
    );
  }

  FutureBuilder<UserData?> signedInHandler(context, WidgetRef ref, User user) {
    final database = ref.read(databaseProvider)!;
    final potentialUserFuture = database.getUser(user.uid);
    return FutureBuilder<UserData?>(
        future: potentialUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final potentialUser = snapshot.data;
            if (potentialUser == null) {
              database.addUser(UserData(
                  email: user.email != null ? user.email! : "",
                  uid: user
                      .uid)); // no need to await as you don't depend on that
            }
            if (user.email == adminEmail) {
              return adminSignedInBuilder(context);
            }
            return signedInBuilder(context);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
