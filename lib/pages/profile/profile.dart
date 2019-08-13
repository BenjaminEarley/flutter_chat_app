import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/blocs/profile/profile_bloc.dart';
import 'package:chat/pages/profile/profile_info.dart';
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
        body: Provider<ProfileBloc>(
          builder: (BuildContext context) => ProfileBloc(_authBloc.getUserId()),
          dispose: (context, value) => value.dispose(),
          child: ProfileInfo(),
        ));
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
