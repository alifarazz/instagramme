import 'package:instagram_1/pages/home_page.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  static String tag = 'edit-profile';

  @override
  State createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  var usernameController = TextEditingController();
  var passController = TextEditingController();
  var bioController = TextEditingController();
  var nameController = TextEditingController();

  BuildContext _scaffoldContext;

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      //keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final pass = TextFormField(
      //keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: passController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final bio = TextFormField(
      //keyboardType: TextInputType.emailAddress,
      autofocus: false,
      autocorrect: true,
      controller: bioController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'Biography',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final username = TextFormField(
      //keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final saveButtom = Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(HomePage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Save', style: TextStyle(color: Colors.blue[50])),
      ),
    );
    final cancelButtom = Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(HomePage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.blueGrey.withOpacity(0.2),
        child: Text('Cancel', style: TextStyle(color: Colors.blue[50])),
      ),
    );

    final body = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: username,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: pass,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: name,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: bio,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 20), child: cancelButtom),
              saveButtom
            ]),
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
