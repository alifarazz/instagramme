import 'package:flutter/material.dart';

import 'package:instagram_1/pages/login_page.dart';
import 'package:instagram_1/main.dart';
import 'package:instagram_1/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
	static String tag = 'signup-page';

	@override
	State createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
	var usernameController = TextEditingController();
	var passwordController = TextEditingController();
	var biographyController = TextEditingController();

	@override
	Widget build(BuildContext context) {
//
//		final avatar2 =  CircleAvatar(
//			backgroundColor: Colors.transparent,
//			child: Image.asset('images/alucard.jpg'),
//			radius: 48.0,
//		)
		final avatar = RawMaterialButton(
			onPressed: (){},
			shape: new CircleBorder(),
			child: CircleAvatar(
				backgroundColor: Colors.transparent,
				child: Image.asset('images/alucard.jpg'),
				radius: 48.0,
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

		final password = TextFormField(
			autofocus: false,
			controller: passwordController,
			obscureText: true,
			decoration: InputDecoration(
				hintText: 'Password',
				contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
				border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
			),
		);

		final biography = TextFormField(
			autofocus: false,
			controller: biographyController,
			decoration: InputDecoration(
				hintText: 'Biography',
				contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
				border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
			),
		);

		final register = Padding(
			padding: EdgeInsets.symmetric(vertical: 14.0),
			child: RaisedButton(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(24),
				),
				onPressed: () {
					Navigator.pop(context);
//					Navigator.of(context).pushReplacementNamed (HomePage.tag);
				},
				padding: EdgeInsets.all(12),
				color: Colors.lightBlueAccent,

				child: Text('Register', style: TextStyle(color: Colors.blue[50])),
			),
		);


		return Scaffold(
			backgroundColor: Colors.blue[50],
			body: Center(
				child: ListView(
					shrinkWrap: true,
					padding: EdgeInsets.only(left: 24.0, right: 24.0),
					children: <Widget>[
						avatar,
						SizedBox(height: 40.0),
						username,
						SizedBox(height: 8.0),
						password,
						SizedBox(height: 8.0),
						biography,
						SizedBox(height: 18.0),
						register
					],
				),
			),
		);
	}


}