import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/registration/logo.dart';
import 'package:chat/pages/registration/registration.dart';
import 'package:chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
            textInputAction: TextInputAction.next,
            onSubmitted: (text) => _nameFocus.requestFocus(),
            decoration: InputDecoration(hintText: "Email"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          TextField(
            controller: _nameController,
            focusNode: _nameFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (text) => _passwordFocus.requestFocus(),
            decoration: InputDecoration(hintText: "Name"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          TextField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            textInputAction: TextInputAction.go,
            obscureText: true,
            onSubmitted: (text) async => await _onSignup(_authBloc),
            decoration: InputDecoration(hintText: "Password"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          RaisedButton(
              child: const Text("Sign Up"),
              onPressed: () async => await _onSignup(_authBloc),
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

  Future _onSignup(AuthBloc bloc) async {
    final email = _emailController.value.text;
    final name = _nameController.value.text;
    final password = _passwordController.value.text;

    FocusNode focus;
    String errorMessage;

    if (password.length < 6) {
      focus = _passwordFocus;
      errorMessage = "Password Too Short";
    }
    if (name.isEmpty) {
      focus = _emailFocus;
      errorMessage = "Name Is Required";
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
      await bloc.signup(email: email, name: name, password: password);
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
