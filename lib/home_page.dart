import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_data/models/item_model.dart';
import 'package:json_data/repository/repository.dart';
import 'package:json_data/utils/auth_utils.dart';
import 'package:json_data/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/counter_box.dart';
import 'package:json_data/resources/news_api_provider.dart';

import 'components/data_table.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;
  NewsApiProvider newsApiProvider;
  String countApi = '/counts';
  final repository = Repository();

  String _authToken;
  var _response;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
    newsApiProvider = NewsApiProvider();
    _authToken;
    _response;
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    setState(() {
      _authToken = 'Bearer ' + authToken;
    });

    final counts = await newsApiProvider.featchCounts(_authToken, countApi);

    setState(() {
      _response = counts;
    });

    if (_authToken == null) {
      _logout();
    }
  }

  _logout() {
    NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
        backgroundColor: Colors.blueAccent,
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Home'),
          actions: <Widget>[
            new MaterialButton(
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Logout',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: _logout),
          ],
        ),
        body: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                counterContainer(height, width, 25, Icons.business,
                    Colors.white, Colors.pink, _response['cases'], 'Cases'),
                counterContainer(height, width, 25, Icons.person, Colors.white,
                    Colors.indigo, _response['borrowers'], 'Borrowers'),
                counterContainer(
                    height,
                    width,
                    25,
                    Icons.camera_roll,
                    Colors.white,
                    Colors.purple,
                    _response['customers'],
                    'Institutes'),
                dataTable(),
              ]),
        ));
  }
}
