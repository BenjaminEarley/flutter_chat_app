import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/registration/logo.dart';
import 'package:chat/pages/registration.dart';
import 'package:chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    final screen = Provider.of<RegistrationScreenState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ...logo,
        TextField(
          controller: _emailController,
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (text) => _passwordFocus.requestFocus(),
          decoration: InputDecoration(hintText: "Email"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextField(
          controller: _passwordController,
          focusNode: _passwordFocus,
          obscureText: true,
          textInputAction: TextInputAction.go,
          onSubmitted: (text) async => await _onLogin(_authBloc),
          decoration: InputDecoration(hintText: "Password"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        RaisedButton(
            child: const Text("Login"),
            onPressed: () async => await _onLogin(_authBloc),
            color: Theme.of(context).primaryColor,
            textTheme: ButtonTextTheme.primary),
        FlatButton(
          child: const Text("Sign Up"),
          onPressed: () => screen.changeScreen(RegistrationScreen.SignUp),
        ),
        FlatButton(
          child: const Text("Forgot Password"),
          onPressed: () => screen.changeScreen(RegistrationScreen.ForgotPassword),
        ),
      ],
    );
  }

  Future _onLogin(AuthBloc bloc) async {
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    FocusNode focus;
    String errorMessage;

    if (password.length < 6) {
      focus = _passwordFocus;
      errorMessage = "Password Too Short";
    }

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
      await bloc.login(email: email, password: password);
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
