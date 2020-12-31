import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/screens/register.dart';
import 'package:multicamp_flutter_app/screens/signInPage.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    debugPrint('|--< authentication build');
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              //title: Text("1 "),
              content: Text(
                AppLocalizations.of(context)
                    .translate('doYouWantToCloseTheApp'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    AppLocalizations.of(context).translate('yes'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () async {
                    SystemNavigator.pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    AppLocalizations.of(context).translate('no'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 40,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 8, right: 8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      Icons.art_track,
                      size: 200,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 40
              ),
              Text(
                AppLocalizations.of(context).translate('appName'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              RaisedButton.icon(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                icon: Icon(Icons.person_add),
                label: Text(
                  AppLocalizations.of(context).translate('register'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton.icon(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
                icon: Icon(Icons.verified_user),
                label: Text(
                  AppLocalizations.of(context).translate('login'),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'by Nihat KARAOĞLU',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
