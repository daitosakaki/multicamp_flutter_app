import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multicamp_flutter_app/appData.dart';
import 'package:multicamp_flutter_app/appLocalizations.dart';
import 'package:multicamp_flutter_app/models/modelNew.dart';
import 'package:multicamp_flutter_app/screens/newView.dart';
import 'package:multicamp_flutter_app/screens/settings.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    debugPrint('|--< homepage build');
    final _appData = Provider.of<AppData>(context);

    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
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
                  onPressed: () async{
                    SystemNavigator.pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('no'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    ),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 5,
          title: TextFormField(
            controller: _searchController,
            focusNode: _searchNode,
            autofocus: false,
            style: Theme.of(context).textTheme.headline1,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              contentPadding: EdgeInsets.only(top: 1, bottom: 1),
              hintText: AppLocalizations.of(context).translate('searchNews'),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 18,
                ),
                onPressed: () {
                  _searchController.clear();
                  _appData.searchCancel();
                },
              ),
            ),
            onEditingComplete: () {
              _appData.search(_searchController.text);
            },
            onChanged: (e){
              if(e.isEmpty) _appData.searchCancel();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                _searchNode.unfocus();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(6),
          itemBuilder: (context, i) {
            if (_appData.notFound) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                  Text(AppLocalizations.of(context).translate("notFound")),
                ),
              );
            } else {
              if (_appData.searchNews.isEmpty) {
                return listItem(context, _appData.news[i]);
              } else {
                return listItem(context, _appData.searchNews[i]);
              }
            }
          },
          separatorBuilder: (context, i) => Divider(height: 8),
          itemCount: (_appData.notFound)
              ? 1
              : _appData.searchNews.isEmpty
              ? _appData.news.length
              : _appData.searchNews.length,
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, NewsModel news){
    return InkWell(
      onTap: (){
        _searchNode.unfocus();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewView(news: news)));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              news.image,
              width: MediaQuery.of(context).size.width / 3,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${news.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 8),
                Text(
                  '${news.description}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}