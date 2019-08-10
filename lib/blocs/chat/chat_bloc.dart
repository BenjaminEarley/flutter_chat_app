import 'dart:async';

import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/blocs/common/bloc_base.dart';
import 'package:chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'chat_state.dart';

class ChatBloc implements BlocBase {
  final AuthBloc _authBloc;
  final CollectionReference _chat =
      Firestore.instance.collection(_chatCollection);
  final CollectionReference _users =
      Firestore.instance.collection(_usersCollection);
  final _counterStateSubject = BehaviorSubject.seeded(defaultState);
  final PublishSubject<Null> _nextChatBlockSubject = PublishSubject();
  Observable<ChatState> get stream => _counterStateSubject.stream.distinct();
  StreamSubscription _userChatStream;
  Observable<QuerySnapshot> _chatStream;
  int messagesLength = 0;

  ChatBloc(this._authBloc) {
    _chatStream = _nextChatBlockSubject.switchMap((_) => _nextChatBlock());

    _userChatStream = Observable.combineLatest2(_chatStream, _users.snapshots(),
        (QuerySnapshot chat, QuerySnapshot users) {
      final messages = chat.documents.map((document) {
        final userId = (document.data[_chatCollectionUserId] as String);
        final type = userId == _authBloc.getUserId()
            ? MessageType.SENT
            : MessageType.RECEIVED;
        return Message(
          body: document.data[_chatCollectionText] as String,
          name: users.documents
              .firstWhere((user) => user.data["userId"] == userId)
              .data["name"]
              .toString(),
          type: type,
        );
      }).toList();
      messagesLength = messages
          .where((message) => message.type != MessageType.MORE_AVAILABLE)
          .length;
      if (messagesLength == limit) {
        return messages..add(Message(type: MessageType.MORE_AVAILABLE));
      } else {
        return messages;
      }
    }).listen((chat) {
      final current = _counterStateSubject.value;
      _counterStateSubject.add(current.copy(
        messages: chat,
        isLoading: false,
      ));
    });
    getNextChatBlock();
  }

  var limit = 0;
  Observable<QuerySnapshot> _nextChatBlock() {
    limit = messagesLength + 100;
    return Observable(_chat
        .orderBy(_chatCollectionTimeStamp, descending: true)
        .limit(limit)
        .snapshots());
  }

  void getNextChatBlock() {
    _nextChatBlockSubject.add(null);
  }

  void sendMessage(String message) {
    _chat.document().setData({
      _chatCollectionText: message.trim(),
      _chatCollectionUserId: _authBloc.getUserId(),
      _chatCollectionTimeStamp: FieldValue.serverTimestamp()
    });
    ChatApp.analytics.logEvent(name: 'send_message');
  }

  @override
  void dispose() {
    _counterStateSubject?.close();
    _nextChatBlockSubject?.close();
    _userChatStream?.cancel();
  }

  static final _chatCollection = 'chat';
  static final _usersCollection = 'users';
  static final _chatCollectionText = 'text';
  static final _chatCollectionUserId = 'userId';
  static final _chatCollectionTimeStamp = 'timestamp';

  static final defaultState = ChatState(
    messages: List(),
    isLoading: true,
  );
}
