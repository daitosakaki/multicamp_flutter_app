import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('|--< splash build');
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 40,
          bottom: MediaQuery.of(context).padding.bottom + 20,
        ),
        child: ListView(
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
            SizedBox(height: 40),
            Text(
              AppLocalizations.of(context).translate('appName'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
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
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
