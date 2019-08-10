import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/chat.dart';
import 'package:chat/pages/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const splashPage = "/";

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    _authBloc.stream.listen((user) {
      if (user.isLoading) return;
      if (user.isLoggedIn) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(chatPage, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(registrationPage, (Route<dynamic> route) => false);
      }
    });
    return const Scaffold(
      body: const Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
