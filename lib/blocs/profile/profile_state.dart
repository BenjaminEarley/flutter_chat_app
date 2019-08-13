import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState extends Equatable {
  final String id;
  final String name;
  final bool isLoading;

  ProfileState({this.id, this.name, this.isLoading})
      : super([id, name, isLoading]);

  ProfileState copy({
    String id,
    String name,
    bool isLoading,
  }) =>
      ProfileState(
        id: id ?? this.id,
        name: name ?? this.name,
        isLoading: isLoading ?? this.isLoading,
      );
}
