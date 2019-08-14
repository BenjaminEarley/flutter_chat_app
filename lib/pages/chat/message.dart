import 'package:chat/blocs/chat/chat_bloc.dart';
import 'package:chat/blocs/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceivedMessage extends StatelessWidget {
  ReceivedMessage(this.message);
  final Message message;

  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 4,
          bottom: 4,
          right: 40.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      message.name,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message.body),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .5,
                            spreadRadius: 1.0,
                            color: Colors.black.withOpacity(.12))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
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
      margin: const EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: 40.0,
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.body,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(.12))
          ],
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
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
