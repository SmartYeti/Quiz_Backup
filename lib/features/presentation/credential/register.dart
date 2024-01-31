import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/core/global_widgets/snackbar.widget.dart';
import 'package:quiz_app/core/utils/guard.dart';
import 'package:quiz_app/features/domain/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/features/domain/model/register_model.dart';
import 'package:quiz_app/features/presentation/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final DIContainer diContainer = DIContainer();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();

  late AuthBloc _authBloc;

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cpasswordController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
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
                  height: 700,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 100,
                          child: Text(
                            'REGISTER',
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
                                  padding: const EdgeInsets.all(5),
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
                                    controller: _lnameController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person_outline_rounded,
                                          color: canvasColor,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Last Name",
                                        hintStyle:
                                            TextStyle(color: canvasColor)),
                                    //   validator: (String? val) {
                                    //   return Guard.againstEmptyString(val, 'Username');
                                    // }
                                    validator: (val) {
                                      return Guard.againstEmptyString(
                                          val, 'Last Name');
                                    },
                                  ),
                                ),
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
                                    controller: _fnameController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person_outline_rounded,
                                          color: canvasColor,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "First Name",
                                        hintStyle:
                                            TextStyle(color: canvasColor)),
                                    //   validator: (String? val) {
                                    //   return Guard.againstEmptyString(val, 'Username');
                                    // }
                                    validator: (val) {
                                      return Guard.againstEmptyString(
                                          val, 'First Name');
                                    },
                                  ),
                                ),
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
                                    //   validator: (String? val) {
                                    //   return Guard.againstEmptyString(val, 'Username');
                                    // }
                                    validator: (val) {
                                      return Guard.againstInvalidEmail(
                                          val, 'Email');
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: canvasColor))),
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
                                          Icons.lock_outline_rounded,
                                          color: canvasColor,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            const TextStyle(color: canvasColor),
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
                                    //   validator: (String? val) {
                                    //   return Guard.againstEmptyString(val, 'Password');
                                    // }
                                    validator: (val) {
                                      return Guard.againstEmptyString(
                                          val, 'Password');
                                    },
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
                                    controller: _cpasswordController,
                                    obscureText: _isObscure2,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.lock_open,
                                          color: canvasColor,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            const TextStyle(color: canvasColor),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure2
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: canvasColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure2 = !_isObscure2;
                                            });
                                          },
                                        )),
                                    //   validator: (String? val) {
                                    //   return Guard.againstEmptyString(val, 'Password');
                                    // }
                                    validator: (String? val) {
                            return Guard.againstNotMatch(
                                val, _passwordController.text, 'Password');
                          },
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
                            _register(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
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
      SnackBarUtils.defualtSnackBar('Success!', context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (BuildContext context) => diContainer.authBloc,
                ),
              ],
              child: HomePage(
                authUserModel: state.authUserModel!,
              ),
            ),
          ),
          ModalRoute.withName('/'));
    }
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(AuthRegisterEvent(
          registerModel: RegisterModel(
              email: _emailController.text,
              password: _passwordController.text,
              confirmPassword: _cpasswordController.text,
              firstName: _fnameController.text,
              lastName: _lnameController.text)));
    }
  }
}

const textColor = Colors.white70;
const canvasColor = Color.fromARGB(255, 33, 32, 75);
const bodyColor = Colors.black12;
const hoverColor = Color.fromARGB(255, 108, 107, 136);
const double textSize = 30;
const double iconSize = 30;
