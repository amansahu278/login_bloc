import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/authentication_bloc/authentication_event.dart';

import 'authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
            },
          )
        ],
      ),
      body: Center(
        child: Text("Welcome $name"),
      )
    );
  }
}
