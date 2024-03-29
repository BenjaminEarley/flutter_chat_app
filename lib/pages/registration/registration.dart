import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/chat/chat.dart';
import 'package:chat/pages/registration/ForgotPassword.dart';
import 'package:chat/pages/registration/sign_in.dart';
import 'package:chat/pages/registration/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const registrationPage = "/registration";

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    _authBloc.stream.listen((user) {
      if (user.isLoading) return;
      if (user.isLoggedIn) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(chatPage, (Route<dynamic> route) => false);
      }
    });
    return ChangeNotifierProvider(
      builder: (context) => RegistrationScreenState(RegistrationScreen.SignIn),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RegistrationScreenPicker(),
        ),
      ),
    );
  }
}

class RegistrationScreenPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<RegistrationScreenState>(context);
    var screenWidget;
    switch (screen.get()) {
      case RegistrationScreen.SignIn:
        screenWidget = SignIn();
        break;
      case RegistrationScreen.SignUp:
        screenWidget = SignUp();
        break;
      case RegistrationScreen.ForgotPassword:
        screenWidget = ForgotPassword();
        break;
    }
    return screenWidget;
  }
}

enum RegistrationScreen { SignIn, SignUp, ForgotPassword }

class RegistrationScreenState with ChangeNotifier {
  RegistrationScreen screen;

  RegistrationScreenState(this.screen);

  get() => screen;

  void changeScreen(RegistrationScreen screen) {
    this.screen = screen;
    notifyListeners();
  }
}
