import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Pair<A, B> extends Equatable {
  final A first;
  final B second;
  Pair(this.first, this.second) : super([first, second]);
}

  bool isValidEmail(String email) =>
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);