import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState extends Equatable {
  final String id;
  final String name;
  final String color;
  final bool isLoading;

  ProfileState({this.id, this.name, this.color, this.isLoading})
      : super([id, name, color, isLoading]);

  ProfileState copy({
    String id,
    String name,
    String color,
    bool isLoading,
  }) =>
      ProfileState(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        isLoading: isLoading ?? this.isLoading,
      );
}