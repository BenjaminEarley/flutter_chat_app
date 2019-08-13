import 'dart:async';

import 'package:chat/blocs/common/bloc_base.dart';
import 'package:chat/blocs/profile/profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc implements BlocBase {
  StreamSubscription _user;
  final _profileStateSubject = BehaviorSubject.seeded(defaultState);
  Observable<ProfileState> get stream => _profileStateSubject.stream.distinct();

  ProfileBloc(String uid) {
    _user = Firestore.instance
        .collection("users")
        .document(uid)
        .snapshots()
        .listen((user) {
      final current = _profileStateSubject.value;
      _profileStateSubject.add(current.copy(
        id: user["userId"],
        name: user["name"],
        isLoading: false,
      ));
    });
  }

  @override
  void dispose() {
    _profileStateSubject?.close();
    _user?.cancel();
  }

  static final defaultState = ProfileState(
    isLoading: true,
  );
}
