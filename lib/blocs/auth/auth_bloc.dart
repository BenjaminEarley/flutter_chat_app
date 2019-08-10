import 'dart:async';

import 'package:chat/blocs/auth/auth_state.dart';
import 'package:chat/blocs/common/bloc_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc implements BlocBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users = Firestore.instance.collection("users");
  final _authStateSubject = BehaviorSubject.seeded(defaultState);
  Observable<AuthState> get stream => _authStateSubject.stream.distinct();
  StreamSubscription<FirebaseUser> _authState;

  AuthBloc() {
    _authState = _auth.onAuthStateChanged.listen((user) {
      final current = _authStateSubject.value;
      if (user != null) {
        _authStateSubject.add(current.copy(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            isLoading: false,
            isLoggedIn: true));
      } else {
        _authStateSubject.add(current.copy(
            id: null,
            name: null,
            email: null,
            isLoading: false,
            isLoggedIn: false));
      }
    });
  }

  Future signup(
      {@required String email,
      @required String name,
      @required String password}) async {
    _authStateSubject.add(_authStateSubject.value.copy(isLoading: true));
    var error;
    try {
      final auth = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _users.document().setData({'userId': auth.user.uid, 'name': name});
    } catch (e) {
      error = e;
    }
    _authStateSubject.add(_authStateSubject.value.copy(isLoading: false));
    throw error;
  }

  Future login({@required String email, @required String password}) async {
    _authStateSubject.add(_authStateSubject.value.copy(isLoading: true));
    var error;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      error = e;
    }
    _authStateSubject.add(_authStateSubject.value.copy(isLoading: false));
    throw error;
  }

  Future isLoginValid() async {
    try {
      await _auth.currentUser().then((user) async => await user.reload());
    } catch (e) {
      return false;
    }
    return true;
  }

  String getUserId() => _authStateSubject.value.id;

  void logout() {
    _auth.signOut();
  }

  @override
  void dispose() {
    _authStateSubject?.close();
    _authState?.cancel();
  }

  static final defaultState = AuthState(isLoading: true, isLoggedIn: false);
}
