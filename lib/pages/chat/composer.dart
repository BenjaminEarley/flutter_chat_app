import 'package:chat/blocs/chat/chat_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Composer extends StatefulWidget {
  const Composer({Key key}) : super(key: key);

  @override
  _ComposerState createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(ChatBloc bloc, String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    _sendMessage(bloc, text);
  }

  void _sendMessage(ChatBloc bloc, String text) {
    if (text.isNotEmpty) bloc.sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ChatBloc>(context);
    return Container(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).accentColor),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onChanged: (String text) {
                      setState(() {
                        _isComposing = text.isNotEmpty;
                      });
                    },
                    textInputAction: TextInputAction.send,
                    onSubmitted: (text) => _handleSubmitted(bloc, text),
                    decoration:
                        InputDecoration.collapsed(hintText: "Send a message"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(bloc, _textController.text)
                        : null,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
