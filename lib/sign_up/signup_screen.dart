import 'package:fiveword/repositorys/authentication_repository.dart';
import 'package:fiveword/sign_up/cubit/signup_cubit.dart';
import 'package:fiveword/sign_up/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: _screenHeight / 20,
          ),
          Lottie.asset('assets/animations/bird.json',
              height: _screenHeight / 3),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) =>
                  SignupCubit(context.read<AuthenticationRepository>()),
              child: SignUpForm(),
            ),
          ),
        ],
      ),
    );
  }
}
