import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../mxins/basic_page_feature.dart';
import '../stores/register_page_store.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with BasicPageFeature {
  final _store = GetIt.instance.get<RegisterPageStore>();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(child: Text("Sign Up", style: Theme.of(context).textTheme.headline5)),
              SizedBox(height: 50),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    _nameTextField(),
                    SizedBox(height: 8),
                    _emailTextField(),
                    SizedBox(height: 8),
                    _passwordTextField(),
                    SizedBox(height: 8),
                    _loginErrorText(),
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

  Widget _nameTextField() {
    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60,
            child: TextField(
              onChanged: (value) => _store.name = value,
              autofocus: true,
              focusNode: _nameFocus,
              onSubmitted: (_) => fieldFocusChange(context, _nameFocus, _emailFocus),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.account_circle),
                hintText: "Name",
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(_store.error.name ?? '', style: TextStyle(color: Theme.of(context).errorColor)),
        ],
      ),
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
              focusNode: _emailFocus,
              onSubmitted: (_) => fieldFocusChange(context, _emailFocus, _passwordFocus),
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
              onSubmitted: (_) => _signUp(),
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

  Widget _signUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 1,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).primaryColor,
        child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        onPressed: _signUp,
      ),
    );
  }

  Future _signUp() async {
    await progressCall(() async {
      final user = await _store.signUp();
      if (user != null) {
        Navigator.of(context).pop(user);
      }
    });
  }
}
