part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignupState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  SignupState copyWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
  }) {
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status);
  }
}
