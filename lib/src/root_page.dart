import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'pages/pages.dart';
import 'stores/app_store.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _store = GetIt.instance.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_store.authStatus == AuthStatus.NOT_LOGGED_IN) {
          return LoginPage();
        } else if (_store.authStatus == AuthStatus.LOGGED_IN) {
          return UserListPage();
        }
        return _loadingScreen();
      },
    );
  }

  Widget _loadingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
