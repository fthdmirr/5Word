import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fiveword/authentication/bloc/authentication_bloc.dart';
import 'package:fiveword/fab_menu/fab_menus.dart';
import 'package:fiveword/word_cards/notification_selected_page.dart';
import 'package:fiveword/word_cards/word_cards.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationSelectedPage(
                id: message['data']['sendCardID'],
              ),
            ),
            (route) => false);
        print("cardID1 :" + message['data']['sendCardID']);
      },
      onBackgroundMessage: null,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationSelectedPage(
                id: message['data']['sendCardID'],
              ),
            ),
            (route) => false);
        print("cardID2 :" + message['data']['sendCardID']);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationSelectedPage(
                id: message['data']['sendCardID'],
              ),
            ),
            (route) => false);
        print("cardID3 :" + message['data']['sendCardID']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabMenu(),
      appBar: AppBar(
        title: const Text('Ana sayfa'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: WordCards(),
    );
  }
}
