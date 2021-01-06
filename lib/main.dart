import 'package:firebase_core/firebase_core.dart';
import 'package:fiveword/authentication/bloc/authentication_bloc.dart';
import 'package:fiveword/home.dart';
import 'package:fiveword/login/login_screen.dart';
import 'package:fiveword/repositorys/authentication_repository.dart';
import 'package:fiveword/repositorys/firebase_card_repository.dart';
import 'package:fiveword/settings/dark_mode/change_theme.dart';
import 'package:fiveword/splash/splash_screen.dart';
import 'package:fiveword/word_cards/bloc/card_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


//TODO:UI kısmını düzenleyeceğiz
//TODO:Bildirim göndermede onwrite deniyiceğiz büyük ihtimal
//Important
//TODO:Google ile giriş
//TODO:Firebase başta olmak üzere bütün kütüphanelerin ios integrasyonunu yap
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => new ThemeNotifier(),
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardBloc(cardRepository: FirebaseCardRepository())
        ..add(CardsLoadSuccessEvent()),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          theme: theme.getTheme(),
          title: "5Words",
          onGenerateRoute: (_) => SplashScreen.route(),
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil(
                        HomePage.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil(
                        LoginScreen.route(), (route) => false);
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
