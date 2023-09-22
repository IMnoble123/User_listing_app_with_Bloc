import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:userslistingapp/features/utils/constants/fonts/font_constnats.dart';

class UserDetailScreen extends StatelessWidget {
  final dynamic user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimationConfiguration.staggeredList(position:1, child:FadeInAnimation(
                duration: const Duration(milliseconds: 500),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user['avatar']),
                ),
              ),),
              SizedBox(height: 20.h),
              AnimationConfiguration.staggeredList(
                position: 2,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    user['first_name'] + ' ' + user['last_name'],
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: AppFont.sfProRegular,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AnimationConfiguration.staggeredList(
                position: 3,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    user['email'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: AppFont.sfProRegular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
