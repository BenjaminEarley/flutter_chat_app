import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const profilePage = "/profile";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (select) => select.action(_authBloc),
              itemBuilder: (BuildContext context) {
                return choices.map((choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: StreamBuilder<AuthState>(
            stream: _authBloc.stream,
            initialData: AuthBloc.defaultState,
            builder: (context, snapshot) {
              if (snapshot.data.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text(snapshot.data.name,
                      style: Theme.of(context).textTheme.headline),
                );
              }
            }));
  }
}

class Choice {
  const Choice({this.title, this.icon, this.action});

  final String title;
  final IconData icon;
  final Function action;
}

List<Choice> choices = <Choice>[
  Choice(
    title: 'Logout',
    icon: Icons.exit_to_app,
    action: (AuthBloc auth) => auth.logout(),
  ),
];
