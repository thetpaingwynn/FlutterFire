import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../models/user.dart';
import '../pages/register_page.dart';
import '../mxins/basic_page_feature.dart';
import '../stores/login_page_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BasicPageFeature {
  final _store = GetIt.instance.get<LoginPageStore>();
  final _userNameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  TextStyle get kLabelStyle => TextStyle(fontWeight: FontWeight.bold);

  BoxDecoration get kBoxDecorationStyle => BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      );

  @override
  void didChangeDependencies() {
    _store.setupValidations();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(child: Text("Login", style: Theme.of(context).textTheme.headline5)),
              SizedBox(height: 50),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _emailTextField(),
                    SizedBox(height: 16),
                    _passwordTextField(),
                    SizedBox(height: 8),
                    _loginErrorText(),
                    _loginButton(),
                    SizedBox(height: 8),
                    _signUpButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      inAsyncCall: inAsyncCall,
    );
  }

  Widget _emailTextField() {
    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60,
            child: TextField(
              onChanged: (value) => _store.email = value,
              autofocus: true,
              focusNode: _userNameFocus,
              onSubmitted: (_) => fieldFocusChange(context, _userNameFocus, _passwordFocus),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(_store.error.email ?? '', style: TextStyle(color: Theme.of(context).errorColor)),
        ],
      ),
    );
  }

  Widget _passwordTextField() {
    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60,
            child: TextField(
              obscureText: true,
              onChanged: (value) => _store.password = value,
              focusNode: _passwordFocus,
              onSubmitted: (_) => _login(),
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock),
                hintText: "Password",
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(_store.error.password ?? '', style: TextStyle(color: Theme.of(context).errorColor)),
        ],
      ),
    );
  }

  Widget _loginErrorText() {
    return Observer(
      builder: (_) {
        return (_store.error.invalidLogin == null) ? SizedBox.shrink() : Text(_store.error.invalidLogin, style: TextStyle(color: Theme.of(context).errorColor));
      },
    );
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 1,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).primaryColor,
        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        onPressed: _login,
      ),
    );
  }

  Widget _signUpButton() {
    return FlatButton(
      child: Text("Don't have an account? Sign up Now.", style: TextStyle(color: Colors.blue[400])),
      onPressed: () async {
        final user = await Navigator.of(context).push(
          MaterialPageRoute<User>(
            builder: (BuildContext context) => RegisterPage(),
            settings: RouteSettings(name: "RegisterPage"),
            fullscreenDialog: true,
          ),
        );
        if (user != null) {
          _store.email = user.email;
          _store.password = user.password;
          await _login();
        }
      },
    );
  }

  Future _login() async {
    if (_store.isValid()) {
      await progressCall(() => _store.signIn());
    }
  }
}
