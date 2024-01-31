import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/core/global_widgets/snackbar.widget.dart';
// import 'package:quiz_app/features/domain/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/features/domain/bloc/quest/quest_bloc.dart';
import 'package:quiz_app/features/domain/model/auth/auth_user.model.dart';
// import 'package:quiz_app/features/domain/model/auth/auth_user.model.dart';
// import 'package:quiz_app/features/presentation/credential/login.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.authUserModel,
    // required this.questDataModel
  });
  final AuthUserModel authUserModel;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final DIContainer diContainer = DIContainer();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  late int page;
  // late AuthBloc _authBloc;
  late QuestBloc _questBloc;
  late AuthUserModel authUserModel;
  // final GlobalKey<FormState> _formKey = GlobalKey();
  late String questId;

  @override
  void initState() {
    super.initState();

    _questBloc = BlocProvider.of<QuestBloc>(context);
    questId = widget.authUserModel.userId;
    _questBloc.add(GetQuestEvent(questId: questId));
    // _authBloc = BlocProvider.of<AuthBloc>(context);
    // _authBloc.add()r
    // _authBloc = BlocProvider.of<AuthBloc>(context);
    // _questBloc = BlocProvider.of<QuestBloc>(context);
    // userId = widget.authUserModel.userId;
    // _questBloc.add(GetQuestEvent(userId:userId));
    // _authBloc.add(AuthAutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestBloc, QuestState>(
        bloc: _questBloc,
        listener: _questListener,
        builder: (context, questState) {
          if (questState.stateStatus == StateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Container(
              color: bodyColor,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   // color: canvasColor,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: canvasColor,
                    //     boxShadow: const [
                    //       BoxShadow(
                    //           color: Colors.black38,
                    //           blurRadius: 5.0,
                    //           offset: Offset(0, 3))
                    //     ],
                    //   ),
                    //   padding: const EdgeInsets.all(10),
                    //   child:  Text('Question $page',
                    //       style: const TextStyle(color: textColor, fontSize: textSize)),
                    // ),
                    SizedBox(
                      width: 900,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Builder(builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 600,
                              width: 800,
                              child: Builder(builder: (context) {
                                if (questState.isEmpty == true) {
                                  return const Center(
                                    child: Text('No Question to display'),
                                  );
                                }
                                return PageView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: questState.questList.length,
                                  itemBuilder: (context, index) {
                                    final questdataList =
                                        questState.questList[index];
                                    page = index + 1;

                                    final screenSize =
                                        MediaQuery.of(context).size;
                                    List<String> choices = [
                                      questdataList.choice1,
                                      questdataList.choice2,
                                      questdataList.choice3,
                                      questdataList.choice4
                                    ];
                                    choices.shuffle();
                                    final setChoice1 = choices[0].toString();
                                    final fchoice1 = setChoice1;
                                    return Container(
                                      height: 200,
                                      width: 100,
                                      margin: const EdgeInsets.only(
                                          bottom: 10, right: 20, left: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: canvasColor,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 3))
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            height: screenSize.width / 3,
                                            padding: const EdgeInsets.all(20),
                                            child: Text('Question $page',
                                                style: const TextStyle(
                                                    color: textColor,
                                                    fontSize: textSize)),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(
                                                    questdataList.question,
                                                    style: const TextStyle(
                                                        color: textColor,
                                                        fontSize: textSize)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                                child: Divider(
                                                  color: textColor,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          activeColor:
                                                              checkColor,
                                                          value: isChecked,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              isChecked =
                                                                  value!;
                                                              // isChecked1 =
                                                              //     false;
                                                              // isChecked2 =
                                                              //     false;
                                                              // isChecked3 =
                                                              //     false;
                                                            });
                                                          },
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            fchoice1,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize:
                                                                    textSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          activeColor:
                                                              checkColor,
                                                          value: isChecked1,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              isChecked1 =
                                                                  value!;
                                                              isChecked = false;
                                                              isChecked2 =
                                                                  false;
                                                              isChecked3 =
                                                                  false;
                                                            });
                                                          },
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            choices[1]
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize:
                                                                    textSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          activeColor:
                                                              checkColor,
                                                          value: isChecked2,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              isChecked2 =
                                                                  value!;
                                                              isChecked1 =
                                                                  false;
                                                              isChecked = false;
                                                              isChecked3 =
                                                                  false;
                                                            });
                                                          },
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            choices[2]
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize:
                                                                    textSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          activeColor:
                                                              checkColor,
                                                          value: isChecked3,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              isChecked3 =
                                                                  value!;
                                                              isChecked1 =
                                                                  false;
                                                              isChecked2 =
                                                                  false;
                                                              isChecked = false;
                                                            });
                                                          },
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            choices[3]
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize:
                                                                    textSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _questListener(BuildContext context, QuestState questState) {
    if (questState.stateStatus == StateStatus.error) {
      const Center(child: CircularProgressIndicator());
      SnackBarUtils.defualtSnackBar(questState.errorMessage, context);
    }
  }

  // void _authListener(BuildContext context, AuthState state) {
  //   if (state.stateStatus == StateStatus.error) {
  //     SnackBarUtils.defualtSnackBar(state.errorMessage, context);
  //     return;
  //   }

  //   if (state.stateStatus == StateStatus.initial) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => MultiBlocProvider(providers: [
  //             BlocProvider<AuthBloc>(
  //                 create: (BuildContext context) => diContainer.authBloc),
  //             BlocProvider<QuestBloc>(
  //                 create: (BuildContext context) => diContainer.questBloc)
  //           ], child: const LoginPage()),
  //         ),
  //         ModalRoute.withName('/'));
  //   }
  // }
}

const textColor = Colors.white70;
const canvasColor = Color.fromARGB(255, 33, 32, 75);
const bodyColor = Colors.black12;
const hoverColor = Color.fromARGB(255, 108, 107, 136);
const double textSize = 17;
const double iconSize = 30;
const checkColor = Colors.green;
