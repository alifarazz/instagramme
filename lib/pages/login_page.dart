import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:instagram_1/main.dart';
import 'package:instagram_1/pages/sign_up_page.dart';
import 'package:instagram_1/shared_prefs.dart';
import 'package:instagram_1/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  static String user = 'q';
  static String pass = '1';

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _scaffoldContext;

  var usernameText = TextEditingController();
  var passText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('images/avatar.png'),
      ),
    );

    void _wrongUserPassSnackbar() {
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1200),
          backgroundColor: Colors.blueGrey,
          content: Text("Wrong username or password")));
    }

    var username = TextFormField(
      //keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: usernameText,
      //initialValue: '',
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    var password = TextFormField(
      autofocus: false,
      controller: passText,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (username.controller.text == LoginPage.user &&
              password.controller.text == LoginPage.pass) {
            // update  uid in prefs
            MySharedPrefs.prefs.then((prefs) {
              prefs.setString("uid", "1");
            });
//            Navigator.of(context).dispose(); // remove LoginPage
            Navigator.of(context).pushReplacementNamed(HomePage.tag);
//            Navigator.of(context).pushNamed(HomePage.tag); // push HomePage
          } else
            _wrongUserPassSnackbar();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.blue[50])),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    final buttonBox = Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        //SizedBox(width: 40.0),
        loginButton,
        signUpButton
      ],
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    var body = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: username,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: password,
            ),
            buttonBox,
            forgotLabel
          ],
        ));
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blue[50],
        body: Builder(builder: (BuildContext context) {
          _scaffoldContext = context;
          return body;
        }));
  }
}
