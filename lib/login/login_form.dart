
import 'package:fiveword/login/cubit/login_cubit.dart';
import 'package:fiveword/sign_up/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text("Hata,Lütfen email ve şifreyi kontrol ediniz")));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/fw_logo.png',
                  height: _screenHeight / 3,
                ),
                SizedBox(
                  height: _screenHeight / 20,
                ),
                _EmailInput(),
                SizedBox(
                  height: _screenHeight / 100,
                ),
                _PasswordInput(),
                SizedBox(
                  height: _screenHeight / 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: GoogleFonts.lato(
                            fontSize: _screenHeight / 20,
                            color: const Color(0xFF505784)),
                      ),
                      _LoginButton(),
                    ],
                  ),
                ),
                SizedBox(
                  height: _screenHeight / 15,
                ),
                _GoogleLoginButton(),
                SizedBox(
                  height: _screenHeight / 200,
                ),
                _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: const Color(0xFF505784)),
              errorText: state.email.invalid ? 'Lütfen bir email giriniz' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Şifre',
              labelStyle: TextStyle(color: const Color(0xFF505784)),
              errorText: state.password.invalid
                  ? 'Şifre eşleşmedi, lütfen tekrar deneyiniz'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF505784),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                      size: _screenHeight / 13,
                    ),
                  ),
                ),
                onTap: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: const Text(
        'GOOGLE İLE GİRİŞ YAP',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: const Color(0xFF505784),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: Text(
        'HESAP OLUŞTUR',
        style: TextStyle(color: const Color(0xFF505784)),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
    );
  }
}
