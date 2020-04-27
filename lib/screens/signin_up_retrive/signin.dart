import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:json_data/blocs/bloc.dart';
import 'package:json_data/blocs/provider.dart';

import 'package:json_data/screens/signin_up_retrive/forms.dart';
import 'package:json_data/utils/auth_utils.dart';
import 'package:json_data/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_data/models/item_model.dart';

import '../../home_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with Forms {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscure = true;
  bool _isloading = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    if (authToken != null) {
      Navigator.of(_scaffoldKey.currentContext)
          .pushReplacementNamed(HomePage.routeName);
    }
  }

  _showLoading() {
    setState(() {
      _isloading = true;
    });
  }

  _hideLoading() {
    setState(() {
      _isloading = false;
    });
  }

  _authenticateUser(e, p) async {
    _showLoading();
    if (_valid()) {
      var responseJson = await NetworkUtils.authenticateUser(e, p);

      print(responseJson);

      if (responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        NetworkUtils.showSnackBar(_scaffoldKey, null);
      } else {
        AuthUtils.insertDetails(_sharedPreferences, responseJson);
        // NetworkUtils.showSnackBar(_scaffoldKey, responseJson['message']);
        /**
				 * Removes stack and start with the new page.
				 * In this case on press back on HomePage app will exit.
				 * **/
        Navigator.of(_scaffoldKey.currentContext)
            .pushReplacementNamed(HomePage.routeName);
      }
      _hideLoading();
    } else {
      setState(() {
        _isloading = false;
      });
    }
  }

  _valid() {
    bool valid = true;

    return valid;
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        return RaisedButton(
          padding: EdgeInsets.all(8),
          color: Colors.indigo,
          onPressed: () {
            setState(() {
              _isloading = true;
            });
            bloc.submit();
            _authenticateUser(snapshot.data[0], snapshot.data[1]);
          },
          child: Text(
            'sign in',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  // Widget ftrPassStr(Bloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.password,
  //     builder: (password, snapshot) {
  //       return !snapshot.hasData
  //           ? FlutterPasswordStrength(
  //               password: "",
  //               strengthCallback: (strength) {},
  //             )
  //           : FlutterPasswordStrength(
  //               password: snapshot.data,
  //               strengthCallback: (strength) {},
  //             );
  //     },
  //   );
  // }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (password, snapshot) {
        return TextFormField(
          onChanged: bloc.changedPassword,
          obscureText: _obscure,
          decoration: InputDecoration(
            focusColor: Colors.green.withOpacity(.4),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            errorText: snapshot.error,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            filled: true,
            hoverColor: Colors.indigo,
            fillColor: Colors.pink.withOpacity(.2),
            prefixIcon: new GestureDetector(
                child: snapshot.hasError
                    ? Icon(Icons.lock, color: Colors.red)
                    : Icon(
                        Icons.lock,
                        color: Colors.purple,
                      )),
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
              child: !_obscure
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
            ),
          ),
        );
      },
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changEmail,
            decoration: InputDecoration(
                focusColor: Colors.green.withOpacity(.4),
                hintText: 'example@dom.com',
                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                errorText: snapshot.error,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                filled: true,
                hoverColor: Colors.indigo,
                fillColor: Colors.pink.withOpacity(.2),
                prefixIcon: Icon(Icons.email),
                suffixIcon: !snapshot.hasData
                    ? Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.green,
                      )),
          );
        });
  }

  // Widget _loadingScreen() {
  //   return new Container(
  //       margin: const EdgeInsets.only(top: 100.0),
  //       child: new Center(
  //           child: new Column(
  //         children: <Widget>[
  //           new CircularProgressIndicator(strokeWidth: 4.0),
  //           new Container(
  //             padding: const EdgeInsets.all(8.0),
  //             child: new Text(
  //               'Please Wait',
  //               style:
  //                   new TextStyle(color: Colors.grey.shade500, fontSize: 16.0),
  //             ),
  //           )
  //         ],
  //       )));
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.indigo.withAlpha(500),
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white70.withOpacity(.2),
          ),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  emailField(bloc),
                  passwordField(bloc),
                  // ftrPassStr(bloc),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                  ),
                  _isloading ? CircularProgressIndicator() : submitButton(bloc),
                ]),
          ),
        ),
      ),
    );
  }
}
