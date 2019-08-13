import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/registration/logo.dart';
import 'package:chat/pages/registration/registration.dart';
import 'package:chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    final screen = Provider.of<RegistrationScreenState>(context);
    return WillPopScope(
      onWillPop: () async {
        screen.changeScreen(RegistrationScreen.SignIn);
        return false;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ...logo,
          TextField(
            controller: _emailController,
            focusNode: _emailFocus,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(hintText: "Email"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          RaisedButton(
              child: const Text("Forgot Password"),
              onPressed: () async => await _onForgotPassword(_authBloc),
              color: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary),
          FlatButton(
            child: const Text("Sign In"),
            onPressed: () => screen.changeScreen(RegistrationScreen.SignIn),
          ),
        ],
      ),
    );
  }

  Future _onForgotPassword(AuthBloc bloc) async {
    final email = _emailController.value.text;

    FocusNode focus;
    String errorMessage;

    if (!isValidEmail(email)) {
      focus = _emailFocus;
      errorMessage = "Invalid Email";
    }

    if (focus != null) {
      focus.requestFocus();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      return;
    }

    try {
      if (await bloc.forgotPassword(email: email)) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Check your email to reset your password."),
        ));
      }
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
