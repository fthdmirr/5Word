
import 'package:fiveword/login/cubit/login_cubit.dart';
import 'package:fiveword/login/login_form.dart';
import 'package:fiveword/repositorys/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: LoginForm(),
      ),
    );
  }
}
