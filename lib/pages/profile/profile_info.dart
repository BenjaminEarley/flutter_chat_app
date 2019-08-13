import 'package:chat/blocs/profile/profile_bloc.dart';
import 'package:chat/blocs/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _profileBloc = Provider.of<ProfileBloc>(context);
    return StreamBuilder<ProfileState>(
      stream: _profileBloc.stream,
      initialData: ProfileBloc.defaultState,
      builder: (context, snapshot) => Center(
        child: snapshot.data.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 96,
                  ),
                  Padding(padding: EdgeInsets.all(16.0)),
                  Text(
                    snapshot?.data?.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ],
              ),
      ),
    );
  }
}
