import 'package:flutter/material.dart';
import 'package:multicamp_flutter_app/models/modelNew.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewView extends StatefulWidget {
  final NewsModel news;

  const NewView({Key key, @required this.news}) : super(key: key);

  @override
  _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  @override
  Widget build(BuildContext context) {
    debugPrint('|--< newView build');
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          widget.news.title,
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await Share.share('${widget.news.title} ${widget.news.link}');
            },
          )
        ],
      ),
      body: WebView(
        initialUrl: widget.news.link,
      ),
    );
  }
}
