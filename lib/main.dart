import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multicamp_flutter_app/appData.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/screens/authentication.dart';
import 'package:multicamp_flutter_app/screens/homepage.dart';
import 'package:multicamp_flutter_app/screens/networkError.dart';
import 'package:multicamp_flutter_app/screens/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppData>(create: (_) => AppData()),
      ],
      child: MyApp(),
    ),
  );
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint('|----< application started');
    String _fontFamily = 'Ubuntu';
    double _enabledBorderWidth = 1;
    double _focusedBorderWidth = 1;
    double _subtitleFontSize = 14;
    double _bodyFontSize = 16;
    double _headlineFontSize = 18;
    Color _themeColor = Colors.cyan;

    final _appData = Provider.of<AppData>(context);
    return MaterialApp(
      onGenerateTitle: (context) =>
          AppLocalizations.of(context).translate('appName'),
      debugShowCheckedModeBanner: false,
      home: (_appData.appState == AppState.networkError)
          ? NetworkError()
          : (_appData.appState != AppState.idle)
          ? Splash()
          : (_auth.currentUser != null)
          ? HomePage()
          : Authentication(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
      theme: (_appData.themeName == 'Black')
          ? ThemeData(
        toggleableActiveColor: _themeColor,
        fontFamily: _fontFamily,
        brightness: Brightness.dark,
        //primarySwatch: _themeColor,
        dialogTheme: DialogTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: Colors.black,
        cursorColor: _themeColor,
        primaryColor: _themeColor,
        accentColor: _themeColor,
        primaryColorDark: _themeColor,
        buttonColor: _themeColor,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
            ),
            subtitle2: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              fontSize: _bodyFontSize,
            ),
            bodyText2: TextStyle(
              fontSize: _bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            headline1: TextStyle(
              color: _themeColor,
              fontSize: _headlineFontSize,
            ),
            headline2: TextStyle(
              color: _themeColor,
              fontWeight: FontWeight.bold,
              fontSize: _headlineFontSize,
            ),
          ),
          iconTheme: IconThemeData(
            color: _themeColor,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          subtitle2: TextStyle(
            fontSize: _subtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: _bodyFontSize,
          ),
          bodyText2: TextStyle(
            fontSize: _bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: _headlineFontSize,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _headlineFontSize,
          ),
          headline3: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _bodyFontSize,
              color: _themeColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          labelStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
          hintStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),

          //contentPadding: EdgeInsets.only(bottom: 20),
          focusColor: _themeColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _enabledBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _focusedBorderWidth,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: _themeColor,
          contentTextStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
        ),
      )
          : (_appData.themeName == 'Navy')
          ? ThemeData(
        toggleableActiveColor: _themeColor,
        fontFamily: _fontFamily,
        brightness: Brightness.dark,
        //primarySwatch: _themeColor,
        dialogTheme: DialogTheme(backgroundColor: Color(0xff15202B)),
        scaffoldBackgroundColor: Color(0xff15202B),
        bottomAppBarColor: Color(0xff15202B),
        canvasColor: Color(0xff15202B),
        cardColor: Color(0xff15202B),
        cursorColor: _themeColor,
        primaryColor: _themeColor,
        accentColor: _themeColor,
        primaryColorDark: _themeColor,
        buttonColor: _themeColor,
        bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff15202B)),
        appBarTheme: AppBarTheme(
          color: Color(0xff15202B),
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
            ),
            subtitle2: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              fontSize: _bodyFontSize,
            ),
            bodyText2: TextStyle(
              fontSize: _bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            headline1: TextStyle(
              color: _themeColor,
              fontSize: _headlineFontSize,
            ),
            headline2: TextStyle(
              color: _themeColor,
              fontWeight: FontWeight.bold,
              fontSize: _headlineFontSize,
            ),
          ),
          iconTheme: IconThemeData(
            color: _themeColor,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color(0xff15202B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          subtitle2: TextStyle(
            fontSize: _subtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: _bodyFontSize,
          ),
          bodyText2: TextStyle(
            fontSize: _bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: _headlineFontSize,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _headlineFontSize,
          ),
          headline3: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _bodyFontSize,
              color: _themeColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          labelStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
          hintStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),

          //contentPadding: EdgeInsets.only(bottom: 20),
          focusColor: _themeColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _enabledBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _focusedBorderWidth,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: _themeColor,
          contentTextStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
        ),
      )
          : (_appData.themeName == 'Blue grey')
          ? ThemeData(
        toggleableActiveColor: _themeColor,
        fontFamily: _fontFamily,
        brightness: Brightness.dark,
        //primarySwatch: _themeColor,
        dialogTheme: DialogTheme(
            backgroundColor: Colors.blueGrey.shade900),
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        bottomAppBarColor: Colors.blueGrey.shade900,
        canvasColor: Colors.blueGrey.shade900,
        cardColor: Colors.blueGrey.shade900,
        cursorColor: _themeColor,
        primaryColor: _themeColor,
        accentColor: _themeColor,
        primaryColorDark: _themeColor,
        buttonColor: _themeColor,
        bottomAppBarTheme:
        BottomAppBarTheme(color: Colors.blueGrey.shade900),
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey.shade900,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
            ),
            subtitle2: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              fontSize: _bodyFontSize,
            ),
            bodyText2: TextStyle(
              fontSize: _bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            headline1: TextStyle(
              color: _themeColor,
              fontSize: _headlineFontSize,
            ),
            headline2: TextStyle(
              color: _themeColor,
              fontWeight: FontWeight.bold,
              fontSize: _headlineFontSize,
            ),
          ),
          iconTheme: IconThemeData(
            color: _themeColor,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.blueGrey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          subtitle2: TextStyle(
            fontSize: _subtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: _bodyFontSize,
          ),
          bodyText2: TextStyle(
            fontSize: _bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: _headlineFontSize,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _headlineFontSize,
          ),
          headline3: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _bodyFontSize,
              color: _themeColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          labelStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
          hintStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),

          //contentPadding: EdgeInsets.only(bottom: 20),
          focusColor: _themeColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _enabledBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _focusedBorderWidth,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: _themeColor,
          contentTextStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
        ),
      )
          : ThemeData(
        toggleableActiveColor: _themeColor,
        fontFamily: _fontFamily,
        brightness: Brightness.light,
        //primarySwatch: _themeColor,
        dialogTheme: DialogTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarColor: Colors.white,
        canvasColor: Colors.white,
        cardColor: Colors.white,
        cursorColor: _themeColor,
        primaryColor: _themeColor,
        accentColor: _themeColor,
        primaryColorDark: _themeColor,
        buttonColor: _themeColor,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
            ),
            subtitle2: TextStyle(
              color: _themeColor,
              fontSize: _subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              fontSize: _bodyFontSize,
            ),
            bodyText2: TextStyle(
              fontSize: _bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            headline1: TextStyle(
              color: _themeColor,
              fontSize: _headlineFontSize,
            ),
            headline2: TextStyle(
              color: _themeColor,
              fontWeight: FontWeight.bold,
              fontSize: _headlineFontSize,
            ),
          ),
          iconTheme: IconThemeData(
            color: _themeColor,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          subtitle2: TextStyle(
            fontSize: _subtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: _bodyFontSize,
          ),
          bodyText2: TextStyle(
            fontSize: _bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: _headlineFontSize,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _headlineFontSize,
          ),
          headline3: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _bodyFontSize,
              color: _themeColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            fontSize: _subtitleFontSize,
          ),
          labelStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
          hintStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),

          //contentPadding: EdgeInsets.only(bottom: 20),
          focusColor: _themeColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _enabledBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _themeColor,
              width: _focusedBorderWidth,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: _themeColor,
          contentTextStyle: TextStyle(
            fontSize: _bodyFontSize,
          ),
        ),
      ),
    );
  }
}
