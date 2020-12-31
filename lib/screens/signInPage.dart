import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/screens/homepage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _scaffoldSignInKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('|--< signInPage build');
    return Scaffold(
      key: _scaffoldSignInKey,
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          AppLocalizations.of(context).translate('login'),
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).translate('email'),
                  hintText: AppLocalizations.of(context)
                      .translate('enterYourEMailAddress'),
                ),
                onEditingComplete: () {
                  _passwordNode.requestFocus();
                },
                validator: (value) {
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
                style: Theme.of(context).textTheme.bodyText1,
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
              ),
              SizedBox(height: 20),
              RaisedButton.icon(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    debugPrint('|--< try signInWithEmail: ${_emailController.text} andPassword: ${_passwordController.text}');
                    try {
                      final User user = (await _auth.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ))
                          .user;
                      final snackBar = SnackBar(
                        content: Text(
                            AppLocalizations.of(context).translate('loggedIn') +
                                "(${user.email})"),
                      );
                      _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } on FirebaseAuthException catch (e) {
                      debugPrint('|--< FirebaseAuthException: ' + e.toString());
                      if (e.toString() == "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                        final snackBar = SnackBar(
                          content: Text(
                            AppLocalizations.of(context).translate(
                                'thePasswordIsInvalidOrTheUserDoesNotHaveAPassword'),
                          ),
                        );
                        _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                      }
                      else if (e.toString() == "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.") {
                        final snackBar = SnackBar(
                          content: Text(
                            AppLocalizations.of(context).translate(
                                'weHaveBlockedAllRequestsFromThisDeviceDueToUnusualActivityTryAgainLater'),
                          ),
                        );
                        _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                      }
                      else if (e.toString() == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                        final snackBar = SnackBar(
                          content: Text(
                            AppLocalizations.of(context).translate(
                                'thereIsNoUserRecordCorrespondingToThisIdentifierTheUserMayHaveBeenDeleted'),
                          ),
                        );
                        _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                      }
                    } catch (e) {
                      debugPrint('|--< catch: ' + e.toString());
                      final snackBar = SnackBar(
                        content: Text(
                          AppLocalizations.of(context)
                              .translate('anUnknownErrorHasOccurred'),
                        ),
                      );
                      _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                    }
                  }
                },
                icon: Icon(Icons.alternate_email),
                label: Text(
                  AppLocalizations.of(context).translate('loginWithEMail'),
                ),
              ),
              SizedBox(height: 20),
              Row(children: <Widget>[
                Expanded(child: Divider()),
                SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context).translate('or'),
                ),
                SizedBox(width: 20),
                Expanded(child: Divider()),
              ]),
              SizedBox(height: 20),
              RaisedButton.icon(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () async {
                  try {
                    final GoogleSignInAccount googleUser =
                    await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;
                    final GoogleAuthCredential googleAuthCredential =
                    GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    final UserCredential userCredential =
                    await _auth.signInWithCredential(googleAuthCredential);
                    final user = userCredential.user;

                    final snackBar = SnackBar(
                      content: Text(
                          AppLocalizations.of(context).translate('loggedIn') +
                              "(${user.email})"),
                    );
                    _scaffoldSignInKey.currentState.showSnackBar(snackBar);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } on FirebaseAuthException catch (e) {
                    debugPrint('|--< FirebaseAuthException: ' + e.toString());
                    final snackBar = SnackBar(
                      content: Text("${e.message}"),
                    );
                    _scaffoldSignInKey.currentState.showSnackBar(snackBar);

                  } catch (e) {
                    debugPrint('|--< catch: ' + e.toString());
                    final snackBar = SnackBar(
                      content: Text(AppLocalizations.of(context)
                          .translate('anUnknownErrorHasOccurred')),
                    );
                    _scaffoldSignInKey.currentState.showSnackBar(snackBar);
                  }
                },
                icon: Image.asset(
                  'assets/image/googleLogo.png',
                  width: 30,
                ),
                label: Text(
                  AppLocalizations.of(context).translate('loginWithGoogle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

