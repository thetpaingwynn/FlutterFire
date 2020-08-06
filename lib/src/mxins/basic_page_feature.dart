import 'package:flutter/material.dart';

mixin BasicPageFeature<T extends StatefulWidget> on State<T> {
  bool inAsyncCall = false;

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<bool> progressCall(Function call) async {
    try {
      setState(() => inAsyncCall = true);
      await call();
      setState(() => inAsyncCall = false);
      return true;
    } catch (e) {
      setState(() => inAsyncCall = false);
      return false;
    }
  }

  Future<bool> confirm(String message) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(message, style: Theme.of(context).textTheme.headline6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Yes', style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  RaisedButton(
                    child: Text('No'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
    );
    return result ?? false;
  }
}
