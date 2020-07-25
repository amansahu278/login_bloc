import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/authentication_bloc/authentication_bloc.dart';
import 'package:login_bloc/simple_bloc_observer.dart';
import 'package:login_bloc/splash_screen.dart';
import 'authentication_bloc/authentication_event.dart';
import 'package:login_bloc/user_repository.dart';

import 'authentication_bloc/authentication_state.dart';
import 'home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  //Required in flutter v1.9.4+
  final UserRepository userRepository = UserRepository();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)..add(AuthenticationStarted()),
      child: App(userRepository: userRepository,),
    )
  );
}
class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationInitial){
            return SplashScreen();
          } else if (state is AuthenticationSuccess){
            return HomeScreen(name: state.displayName,);
          }
          return Container();
        },
      ),
    );
  }
}