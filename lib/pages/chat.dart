import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/blocs/chat/chat_bloc.dart';
import 'package:chat/pages/chat/composer.dart';
import 'package:chat/pages/chat/messages.dart';
import 'package:chat/pages/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const chatPage = "chat";

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  void _select(AuthBloc bloc, Choice choice) {
    switch (choice) {
      case Choice.Logout:
        bloc.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    _authBloc.stream.listen((user) {
      if (user.isLoading) return;
      if (!user.isLoggedIn) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            registrationPage, (Route<dynamic> route) => false);
      }
    });
    return Provider<ChatBloc>(
      builder: (context) => ChatBloc(_authBloc),
      dispose: (context, value) => value.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (select) => _select(_authBloc, select),
              itemBuilder: (BuildContext context) {
                return Choice.values.map((choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(_getTitle(choice)),
                  );
                }).toList();
              },
            ),
          ],
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: const Chat(),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Messages(),
      const Divider(height: 1.0),
      const Composer(),
    ]);
  }
}

enum Choice { Logout }

String _getTitle(Choice choice) {
  switch (choice) {
    case Choice.Logout:
      return "Logout";
    default:
      return "";
  }
}
