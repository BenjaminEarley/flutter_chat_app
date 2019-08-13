import 'package:chat/blocs/chat/chat_bloc.dart';
import 'package:chat/blocs/chat/chat_state.dart';
import 'package:chat/pages/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ChatBloc>(context);
    return StreamBuilder<ChatState>(
      stream: bloc.stream,
      initialData: ChatBloc.defaultState,
      builder: (context, snapshot) => Flexible(
        child: ListView.builder(
          itemCount: snapshot.data?.messages?.length ?? 0,
          reverse: true,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (BuildContext context, int index) {
            final message = snapshot.data.messages[index];
            switch (message.type) {
              case MessageType.RECEIVED:
                return ReceivedMessage(message);
              case MessageType.SENT:
                return SentMessage(message);
              case MessageType.MORE_AVAILABLE:
                return MoreMessages();
            }
            throw Exception();
          },
        ),
      ),
    );
  }
}
