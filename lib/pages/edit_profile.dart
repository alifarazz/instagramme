import 'package:instagram_1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:instagram_1/model/account.dart';
import 'package:instagram_1/main.dart';
import 'package:crypt/crypt.dart';

class EditProfilePage extends StatefulWidget {
	static String tag = 'edit-profile';

	static AccountModel _accountModel;

	static Future <AccountModel> get accountModel async {
		if (_accountModel == null) {
			_accountModel = await AccountModel.getByUID(MyApp.loginUID);
			if (_EditProfilePage.usernameController.text == '')
				_EditProfilePage.usernameController.text = _accountModel.username;
			if (_EditProfilePage.nameController.text == '')
				_EditProfilePage.nameController.text = _accountModel.fullname;
			if (_EditProfilePage.bioController.text == '')
				_EditProfilePage.bioController.text = _accountModel.bio;
		}
		return _accountModel;
	}

		EditProfilePage();
	@override
	State createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
	static var usernameController = TextEditingController();
	static var passController = TextEditingController();
	static var bioController = TextEditingController();
	static var nameController = TextEditingController();

	BuildContext _scaffoldContext;

	@override
	Widget build(BuildContext context) {
		name(String initname) {
			return TextFormField(
				//keyboardType: TextInputType.emailAddress,
				autofocus: false,
				controller: nameController,
				decoration: InputDecoration(
					hintText: 'Name',
					contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
					border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
				),
			);
		}

		final pass = TextFormField(
			//keyboardType: TextInputType.emailAddress,
			autofocus: false,
			obscureText: true,
			controller: passController,
			decoration: InputDecoration(
				hintText: 'Password',
				contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
				border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
			),
		);
		bio(String initbio) {
			return TextFormField(
				//keyboardType: TextInputType.emailAddress,
				autofocus: false,
				autocorrect: true,
				controller: bioController,
				keyboardType: TextInputType.multiline,
				decoration: InputDecoration(
					hintText: 'Biography',
//        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
					border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
				),
			);
		}

		username(String initusername) {
			return TextFormField(
				//keyboardType: TextInputType.emailAddress,
				autofocus: false,
				controller: usernameController,
				decoration: InputDecoration(
					hintText: 'Username',
					contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
					border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
				),
			);
		}

		final saveButtom = Padding(
			padding: EdgeInsets.symmetric(vertical: 14.0),
			child: RaisedButton(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(24),
				),
				onPressed: () async {
					if (usernameController.text.length < 1) {
//            Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
//                duration: Duration(milliseconds: 1200),
//                backgroundColor: Colors.blueGrey,
//                content: Text("Username Too Small")));
            debugPrint("[UPDATE] bad username");
						return;
					}
					if (passController.text.length < 1) {
//            Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
//                duration: Duration(milliseconds: 1200),
//                backgroundColor: Colors.blueGrey,
//                content: Text("Password Too Small")));
            debugPrint("[UPDATE] bad pass");
						return;
					}

					final AccountModel _accountModel = await EditProfilePage.accountModel;
					_accountModel.fullname = nameController.text;
					_accountModel.username = usernameController.text;
					_accountModel.bio = bioController.text;
					_accountModel.h_pass =
							Crypt.sha256(passController.text, salt: "abcdefghijklmnop").toString();

					var updatestat = (await _accountModel.update());
					debugPrint("${updatestat}");
					if (UpdateStatus.UsernameNotUnique == updatestat) {
//            Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
//                duration: Duration(milliseconds: 1200),
//                backgroundColor: Colors.blueGrey,
//                content: Text("Username Not Unique")));
						return;
					}
					debugPrint("[UPDATE] Update Successul");
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
				onPressed: ()  {
					EditProfilePage._accountModel = null;
					Navigator.of(context).pushReplacementNamed(HomePage.tag);
//          Navigator.pop(context);
				},
				padding: EdgeInsets.all(12),
				color: Colors.blueGrey.withOpacity(0.2),
				child: Text('Cancel', style: TextStyle(color: Colors.blue[50])),
			),
		);

		body() {
			return Padding(
					padding: EdgeInsets.only(left: 24.0, right: 24.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Padding(
								padding: EdgeInsets.only(bottom: 8.0),
								child: username(''),
							),
							Padding(
								padding: EdgeInsets.only(bottom: 8.0),
								child: pass,
							),
							Padding(
								padding: EdgeInsets.only(bottom: 8.0),
								child: name(''),
							),
							Padding(
								padding: EdgeInsets.only(bottom: 16.0),
								child: bio(''),
							),
							Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
								Padding(padding: EdgeInsets.only(right: 20), child: cancelButtom),
								saveButtom
							]),
						],
					));
		}

		return FutureBuilder(
			future:EditProfilePage.accountModel,
			builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
				return snapshot.hasData
						? Scaffold(
						resizeToAvoidBottomPadding: false,
						backgroundColor: Colors.blue[50],
						body: () {
							_scaffoldContext = context;
//							_accountModel = snapshot.data;
							return body();
						}())
						: CircularProgressIndicator();
			});
	}
}
