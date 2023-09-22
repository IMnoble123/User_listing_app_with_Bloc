import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Dio _dio = Dio();
  int page = 1;

  UserBloc() : super(UserInitial());
@override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUsers) {
      try {
        final response = await _dio.get('https://reqres.in/api/users?page=$page');
        if (response.statusCode == 200) {
          page++;
          final users = response.data['data'];
          yield UserLoadSuccess(users: users);
        } else {
          yield const UserLoadFailure(error: 'Failed to load users');
        }
      } catch (e) {
        yield const UserLoadFailure(error: 'Failed to load users');
      }
    }
  }
}