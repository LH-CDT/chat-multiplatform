import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chat_shared/blocs/user_bloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chat App',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: UsernamePage(),
    );
  }
}

class UsernamePage extends StatefulWidget {
  @override
  UsernamePageState createState() {
    return new UsernamePageState();
  }
}

class UsernamePageState extends State<UsernamePage> {
  final GlobalKey<FormState> _usernameForm = GlobalKey();

  UserBloc bloc;

  Future<Null> _usernameSet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: Form(
        key: _usernameForm,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                autocorrect: false,
                onSaved: (username) {
                  bloc.username.add(username);
                },
                decoration: InputDecoration(
                  labelText: "Nick",
                  hintText: "Pick your nickname",
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              RaisedButton(
                child: Text("OK"),
                onPressed: () {
                  _usernameForm.currentState.save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc = UserBlocImpl();
    _usernameSet =
        bloc.usernameSet.skipWhile((event) => !event).first.then((_) {
      print("Name set. TODO: trigger navigation");
    }, onError: (e) {
      print("$e happened");
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
