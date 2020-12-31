import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/appData.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/screens/authentication.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('|--< settings build');
    final _appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          AppLocalizations.of(context).translate('settings'),
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        children: [
          Card(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                labelText: AppLocalizations.of(context).translate('appName') +
                    ' v1.0.0',
              ),
            ),
          ),
          Card(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                labelText: AppLocalizations.of(context).translate('email') + ': ' +
                    _auth.currentUser.email,
              ),
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    Icons.invert_colors,
                    //color: Colors.deepPurple,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 5, right: 10, bottom: 5),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(),
                      value: (_appData.themeName == 'Brown')
                          ? AppLocalizations.of(context)
                          .translate('brown')
                          : (_appData.themeName == 'Black')
                          ? AppLocalizations.of(context)
                          .translate('black')
                          : (_appData.themeName == 'Blue grey')
                          ? AppLocalizations.of(context)
                          .translate('blueGrey')
                          : (_appData.themeName == 'Navy')
                          ? AppLocalizations.of(context)
                          .translate('navy')
                          : AppLocalizations.of(context)
                          .translate('white'),
                      onChanged: (value) {
                        if (value ==
                            AppLocalizations.of(context)
                                .translate('white')) {
                          _appData.selectWhite();
                        } else if (value ==
                            AppLocalizations.of(context)
                                .translate('black')) {
                          _appData.selectBlack();
                        } else if (value ==
                            AppLocalizations.of(context)
                                .translate('blueGrey')) {
                          _appData.selectBlueGrey();
                        } else if (value ==
                            AppLocalizations.of(context)
                                .translate('navy')) {
                          _appData.selectNavy();
                        } else {
                          _appData.selectBlueGrey();
                        }
                      },
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: AppLocalizations.of(context)
                              .translate('white'),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('white'),
                            style: TextStyle(
                              color: (_appData.themeName == 'White')
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.headline1.color,
                              fontWeight: (_appData.themeName == 'White')
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: AppLocalizations.of(context)
                              .translate('blueGrey'),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('blueGrey'),
                            style: TextStyle(
                              color: (_appData.themeName == 'Blue grey')
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.headline1.color,
                              fontWeight: (_appData.themeName == 'Blue grey')
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: AppLocalizations.of(context)
                              .translate('navy'),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('navy'),
                            style: TextStyle(
                              color: (_appData.themeName == 'Navy')
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.headline1.color,
                              fontWeight: (_appData.themeName == 'Navy')
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: AppLocalizations.of(context)
                              .translate('black'),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('black'),
                            style: TextStyle(
                              color: (_appData.themeName == 'Black')
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.headline1.color,
                              fontWeight: (_appData.themeName == 'Black')
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Theme(
              data:
              Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                trailing: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_drop_down),
                ),
                tilePadding: EdgeInsets.zero,
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.developer_mode,
                        //color: Colors.deepPurple,
                      ),
                    ),
                    Expanded(
                        child: Text(AppLocalizations.of(context)
                            .translate('developer'))),
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/twitterLogo.png',
                              width: 50,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Nihat KARAOĞLU',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        _launchURL('https://twitter.com/karaoglunihat');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/gitHubLogo.png',
                              width: 50,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'DaitoSAKAKI',
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        _launchURL('https://github.com/daitosakaki/multicamp_flutter_app');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: RaisedButton.icon(
          color: Colors.redAccent,
          padding: EdgeInsets.only(top: 15, bottom: 15),
          onPressed: () async {
            final User user = _auth.currentUser;
            if (user != null) {
              await _auth.signOut();
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Authentication()));
          },
          icon: Icon(Icons.logout),
          label: Text(AppLocalizations.of(context).translate('signOut')),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
