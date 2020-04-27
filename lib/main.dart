import 'package:flutter/material.dart';
import 'package:json_data/home_page.dart';
import 'package:json_data/screens/signin_up_retrive/signin.dart';
import 'blocs/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'My APP',
        theme: ThemeData(),
        home: new SignIn(),
	    routes: {
      	HomePage.routeName: (BuildContext context) => new HomePage()
	    },
      ),
    );
  }
}

// Route routes(RouteSettings settings) {
//   return MaterialPageRoute(builder: (context) {
//     return SignIn();
//   });
// }
