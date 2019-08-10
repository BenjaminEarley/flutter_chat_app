import 'package:chat/blocs/chat/chat_bloc.dart';
import 'package:chat/blocs/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceivedMessage extends StatelessWidget {
  ReceivedMessage(this.message);
  final Message message;

  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(message.name,
                      style: Theme.of(context).textTheme.caption),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(message.body),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class SentMessage extends StatelessWidget {
  SentMessage(this.message);
  final Message message;

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(message.body),
      alignment: Alignment(1.0, 0.0),
    );
  }
}

class MoreMessages extends StatelessWidget {

  Widget build(BuildContext context) {
    final bloc = Provider.of<ChatBloc>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: FlatButton(
        child: Text("Load More"),
        onPressed: () => bloc.getNextChatBlock(),
      ),
      alignment: const Alignment(0.0, 0.0),
    );
  }
}
