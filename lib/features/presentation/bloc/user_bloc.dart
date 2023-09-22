import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Dio _dio = Dio();
  int page = 1;

  UserBloc() : super(UserInitial()) {
     on<FetchUsers>((event, emit) async {
     try {
        final response = await _dio.get('https://reqres.in/api/users?page=$page');
        if (response.statusCode == 200) {
          page++;
          final users = response.data['data'];
          emit(UserLoadSuccess(users: users));
        } else {
          emit(const UserLoadFailure(error: 'Failed to load users'));
        }
      } catch (e) {
         emit(const UserLoadFailure(error: 'Failed to load users'));
      }
    });
  }
  
}
