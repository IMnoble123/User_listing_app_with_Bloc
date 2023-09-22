part of 'user_bloc.dart';


abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadSuccess extends UserState {
  final List<dynamic> users;

  const UserLoadSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoadFailure extends UserState {
  final String error;

  const UserLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
