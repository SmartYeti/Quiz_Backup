import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/features/domain/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/features/domain/bloc/quest/quest_bloc.dart';
import 'package:quiz_app/features/presentation/credential/login.dart';
import 'package:quiz_app/features/presentation/home.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late AuthBloc _authBloc;
  final DIContainer diContainer = DIContainer();

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthAutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: _authListener,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  //Listeners

  void _authListener(BuildContext context, AuthState state) {
    if (state.stateStatus == StateStatus.error ||
        state.authUserModel == null &&
            state.stateStatus == StateStatus.loaded) {
      ///proceed to loginpage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _authBloc,
            child: const LoginPage(),
          ),
        ),
      );
      return;
    }

    if (state.authUserModel != null &&
        state.stateStatus == StateStatus.loaded) {
      ///proceed to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider<AuthBloc>(
                create: (BuildContext context) => diContainer.authBloc),
             BlocProvider<QuestBloc>(
                create: (BuildContext context) => diContainer.questBloc),
           
          ], child: HomePage(
            authUserModel: state.authUserModel!,
            
          )),
        ),
      );
      return;
    }
  }
}
