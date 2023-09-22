import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:userslistingapp/features/presentation/pages/user_details_screen.dart';
import 'package:userslistingapp/features/utils/constants/fonts/font_constnats.dart';
import '../bloc/user_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<UserBloc>().add(FetchUsers());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadSuccess) {
            final users = state.users;
            return AnimationLimiter(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailScreen(user: user),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              user['first_name'] + ' ' + user['last_name'],
                              style:  TextStyle(
                                fontSize: 18.sp,
                                fontFamily: AppFont.sfProRegular,
                              ),
                            ),
                            subtitle: Text(user['email']),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is UserLoadFailure) {
            return Center(
              child: Text('Failed to load users: ${state.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
