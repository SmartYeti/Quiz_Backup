import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/core/global_widgets/snackbar.widget.dart';
import 'package:quiz_app/core/utils/guard.dart';
import 'package:quiz_app/features/domain/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/features/domain/bloc/quest/quest_bloc.dart';
import 'package:quiz_app/features/domain/model/auth/login_model.dart';
import 'package:quiz_app/features/presentation/credential/register.dart';
import 'package:quiz_app/features/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final DIContainer diContainer = DIContainer();
  bool _isObscure = true;

  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: _authBlocListener,
          builder: (context, state) {
            if (state.stateStatus == StateStatus.loading) {
              return _loadingWidget();
            }
            return Container(
              color: canvasColor,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 500,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 100,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: textColor,
                                fontSize: textSize,
                                letterSpacing: .5),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: bodyColor),
                              boxShadow: const [
                                BoxShadow(
                                    color: hoverColor,
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: canvasColor))),
                                  child: TextFormField(
                                      // validator: (String? val) {
                                      //   return Guard.againstInvalidEmail(val, 'Email');
                                      // },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: canvasColor,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: canvasColor)),
                                      validator: (String? val) {
                                        return Guard.againstInvalidEmail(
                                            val, 'Email');
                                      }
                                      //   validator: (String? val) {
                                      //   return Guard.againstEmptyString(val, 'Username');
                                      // }
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      // validator: (String? val) {
                                      //   return Guard.againstEmptyString(
                                      //       val, 'Password');
                                      // },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: _passwordController,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.lock_open,
                                            color: canvasColor,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: const TextStyle(
                                              color: canvasColor),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: canvasColor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                          )),
                                      validator: (String? val) {
                                        return Guard.againstEmptyString(
                                            val, 'Password');
                                      }
                                      //   validator: (String? val) {
                                      //   return Guard.againstEmptyString(val, 'Password');
                                      // }
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => textColor),
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return hoverColor; //<-- SEE HERE
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return bodyColor; //<-- SEE HERE
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Next",

                                style: GoogleFonts.ptSerif(
                                  textStyle: const TextStyle(
                                    color: canvasColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // style: TextStyle(
                                //     color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _login(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                            value: _authBloc,
                                            child: const RegisterPage(),
                                          )));
                              clearText();
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30, child: Divider()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    if (state.stateStatus == StateStatus.error) {
      SnackBarUtils.defualtSnackBar(state.errorMessage, context);
    }

    if (state.authUserModel != null) {
      SnackBarUtils.defualtSnackBar('Login Success!', context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthBloc>(
                          create: (BuildContext context) =>
                              diContainer.authBloc,
                        ),
                        BlocProvider<QuestBloc>(
                          create: (BuildContext context) =>
                              diContainer.questBloc,
                        ),
                      ],
                      child: HomePage(
                        authUserModel: state.authUserModel!,
                      ))),
          ModalRoute.withName('/'));
    }
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthLoginEvent(
          logInModel: LoginModel(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ),
      );
    }
    clearText();
  }
}

const textColor = Colors.white70;
const canvasColor = Color.fromARGB(255, 33, 32, 75);
const bodyColor = Colors.black12;
const hoverColor = Color.fromARGB(255, 108, 107, 136);
const double textSize = 30;
const double iconSize = 30;
