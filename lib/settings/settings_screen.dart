
import 'package:fiveword/authentication/bloc/authentication_bloc.dart';
import 'package:fiveword/settings/dark_mode/change_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Padding(
        padding: EdgeInsets.all(_screenHeight / 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/svg/settings_ill.svg',
              height: _screenHeight / 3,
              fit: BoxFit.fitWidth,
            ),
            Container(
              height: _screenHeight / 15,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_screenHeight / 50),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Text("Email: "),
                  Text(user.email),
                ],
              ),
            ),
            Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return InkWell(
                  child: Container(
                    height: _screenHeight / 15,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Karanlık Mod")),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.black],
                        )),
                  ),
                  onTap: () {
                    theme.getTheme() == theme.darkTheme
                        ? theme.setLightMode()
                        : theme.setDarkMode();
                  },
                );
              },
            ),
            FloatingActionButton.extended(
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
              label: Text("Çıkış"),
              icon: const Icon(Icons.exit_to_app),
              backgroundColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
