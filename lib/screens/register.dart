import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/screens/authentication.dart';
import 'package:multicamp_flutter_app/screens/homepage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldRegisterKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _success = true;
  String _message;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    try {
      debugPrint('|--< try register: ${_emailController.text} andPassword: ${_passwordController.text}');
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        _success = true;
        _message =
            AppLocalizations.of(context).translate('registrationSuccessful') +
                " ${user.email}";
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      }
      else {
        _success = false;
        _message = AppLocalizations.of(context).translate('registrationFailed');
      }

      final snackBar = SnackBar(
        content: Text(_message),
      );
      _scaffoldRegisterKey.currentState.showSnackBar(snackBar);
    } catch (e) {
      debugPrint('|--< catch: ' + e.toString());
      _success = false;

      if (e.toString() ==
          '[firebase_auth/ınvalıd-emaıl] The email address is badly formatted.') {
        _message = AppLocalizations.of(context)
            .translate('theEmailAddressIsBadlyFormatted');
      }
      else if (e.toString() ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        _message = AppLocalizations.of(context)
            .translate('passwordShouldBeAtLeast6Characters');
      }
      else if (e.toString() ==
          '[firebase_auth/emaıl-already-ın-use] The email address is already in use by another account.') {
        _message = AppLocalizations.of(context)
            .translate('theEmailAddressIsAlreadyInUseByAnotherAccount');
      }
      else {
        _message =
            AppLocalizations.of(context).translate('registrationFailed') +
                "\n\n$e";
      }
      final snackBar = SnackBar(
        content: Text(_message),
      );
      _scaffoldRegisterKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('|--< register build');
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Authentication()));
        return null;
      },
      child: Scaffold(
        key: _scaffoldRegisterKey,
        appBar: AppBar(
          leadingWidth: 30,
          title: Text(
            AppLocalizations.of(context).translate('register'),
            style: Theme.of(context).appBarTheme.textTheme.headline1,
          ),
        ),
        body: Form(
          key: _formKeyRegister,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            children: [
              TextFormField(
                autofocus: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                //style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).translate('email'),
                  hintText: AppLocalizations.of(context)
                      .translate('enterYourEMailAddress'),
                ),
                onEditingComplete: () {
                  _passwordNode.requestFocus();
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('pleaseEnterAnEMail');
                  } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return AppLocalizations.of(context)
                        .translate('pleaseEnterAValidEMail');
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordNode,
                //style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).translate('password'),
                  hintText: AppLocalizations.of(context)
                      .translate('enterYourPassword'),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('pleaseSetPassword');
                  } else if (value.length < 6) {
                    return AppLocalizations.of(context).translate(
                        'pleaseSpecifyAPasswordWithAtLeast6Characters');
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              RaisedButton.icon(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () async {
                  if (_formKeyRegister.currentState.validate()) {
                    _register();
                  }
                },
                icon: Icon(Icons.person_add),
                label: Text(
                  AppLocalizations.of(context).translate('register'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  _success == null ? '' : _message ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
