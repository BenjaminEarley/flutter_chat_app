import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
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
  final Color color;
  final MessageType type;

  Message({
    this.body,
    this.name,
    this.color,
    this.type,
  }) : super([body, name, color, type]);

  Message copy({
    String body,
    String name,
    Color color,
    MessageType type,
  }) =>
      Message(
        body: body ?? this.body,
        name: name ?? this.name,
        color: color ?? this.color,
        type: type ?? this.type,
      );
}
