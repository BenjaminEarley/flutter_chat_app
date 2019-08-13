import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState extends Equatable {
  final String id;
  final String email;
  final bool isLoading;
  final bool isLoggedIn;

  AuthState({this.id, this.email, this.isLoading, this.isLoggedIn})
      : super([id, email, isLoading, isLoggedIn]);

  AuthState copy({
    String id,
    String email,
    bool isLoading,
    bool isLoggedIn
  }) =>
      AuthState(
        id: id ?? this.id,
        email: email ?? this.email,
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );
}