part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}
