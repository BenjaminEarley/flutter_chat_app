import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ChatState extends Equatable {
  final List<Message> messages;
  final bool isLoading;

  ChatState({
    this.messages,
    this.isLoading,
  }) : super([messages, isLoading]);

  ChatState copy({
    List<Message> messages,
    bool isLoading,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
      );
}

enum MessageType { SENT, RECEIVED, MORE_AVAILABLE }

@immutable
class Message extends Equatable {
  final String body;
  final String name;
  final MessageType type;

  Message({
    this.body,
    this.name,
    this.type,
  }) : super([body, name, type]);

  Message copy({
    String body,
    String name,
    MessageType type,
  }) =>
      Message(
        body: body ?? this.body,
        name: name ?? this.name,
        type: type ?? this.type,
      );
}
