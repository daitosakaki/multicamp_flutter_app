import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/models/modelNew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

enum AppState{busy, idle, networkError}

class AppData with ChangeNotifier {

  AppData() {
    appState = AppState.busy;
    checkInternet();
    _getData().then((value) {
      if (themeName == 'Black')
        selectBlack();
      else if (themeName == 'White')
        selectWhite();
      else if (themeName == 'Navy')
        selectNavy();
      else
        selectBlueGrey();
    });
  }

  AppState _appState;
  AppState get appState => _appState;
  set appState(AppState value) {
    _appState = value;
    notifyListeners();
  }


  List<NewsModel> _searchNews = List();
  List<NewsModel> get searchNews => _searchNews;
  set searchNews(List<NewsModel> value) {
    _searchNews = value;
    notifyListeners();
  }

  List _news;
  List get news => _news;
  set news( value) {
    _news = value;
    notifyListeners();
  }

  bool _notFound = false;
  bool get notFound => _notFound;
  set notFound(bool value) {
    _notFound = value;
    notifyListeners();
  }

  Future checkInternet() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      debugPrint('|--< check internet... application is online');
      news = await fetchNews();
      debugPrint('|--< news: ' + news.toString());
      Future.delayed(Duration(seconds: 2), () async {
        appState = AppState.idle;
      });
      return;
    }
    debugPrint('|--< check internet... application is offline');
    appState = AppState.networkError;
  }

  Future fetchNews() async {
    debugPrint('|--< fetching news...');
    final _response = await http.get('https://www.aa.com.tr/tr/rss/default?cat=guncel');
    if (_response.statusCode == 200) {
      var _decoded = new RssFeed.parse(_response.body);
      return _decoded.items
          .map((item) => NewsModel(
        link: item.link,
        title: item.title,
        pubDate: item.pubDate,
        image: item.imageUrl,
        description: item.description,
      ))
          .toList();
    } else {
      throw HttpException('Failed to fetch the data');
    }
  }

  search(String wantedNews) {
    debugPrint("|--< searching: $wantedNews");
    notFound = false;
    searchNews = List();
    List<NewsModel> foundNews = _news.where((element) => element.title.toLowerCase().contains(wantedNews.toLowerCase())).toList();

    if (foundNews.isEmpty){
      notFound = true;
      debugPrint("|--< search not found");
    }
    else{
      searchNews = foundNews;
      notFound = false;
      debugPrint("|--< search isEmpty: ${searchNews.isEmpty}");
    }
  }

  searchCancel(){
    searchNews = List();
    notFound = false;
  }

  String _themeName;
  String get themeName => _themeName;
  set themeName(String value) {
    _themeName = value;
    notifyListeners();
  }

  _saveTheme() async {
    SharedPreferences savePref = await SharedPreferences.getInstance();
    await savePref.setString("themeName", themeName);
    debugPrint("|--< theme: $themeName");
  }

  Future<String> _getData() async {
    debugPrint('|--< local data loaded');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeName = prefs.getString("themeName");
    return themeName;
  }

  //Themes
  void selectNavy() {
    themeName = 'Navy';
    _saveTheme();
  }

  void selectWhite() {
    themeName = 'White';
    _saveTheme();
  }

  void selectBlack() {
    themeName = 'Black';
    _saveTheme();
  }

  void selectBlueGrey() {
    themeName = 'Blue grey';
    _saveTheme();
  }

}
