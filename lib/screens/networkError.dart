import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/appData.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:provider/provider.dart';

class NetworkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _appData = Provider.of<AppData>(context);

    return Scaffold(
      body: CupertinoAlertDialog(
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
              AppLocalizations.of(context)
                  .translate('yes'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              _appData.checkInternet();
            },
          ),
        ],
      ),
    );
  }
}
