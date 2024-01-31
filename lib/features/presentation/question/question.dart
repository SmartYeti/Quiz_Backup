import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/core/global_widgets/snackbar.widget.dart';
import 'package:quiz_app/core/utils/guard.dart';
import 'package:quiz_app/features/domain/bloc/quest/quest_bloc.dart';
import 'package:quiz_app/features/domain/model/auth/auth_user.model.dart';
import 'package:quiz_app/features/domain/model/quest/add_quest_model.dart';
import 'package:quiz_app/main.dart';
// import 'package:quiz_app/features/presentation/home.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key, required this.authUserModel});
  final AuthUserModel authUserModel;

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _choice1Controller = TextEditingController();
  final TextEditingController _choice2Controller = TextEditingController();
  final TextEditingController _choice3Controller = TextEditingController();
  final TextEditingController _correctController = TextEditingController();
  final DIContainer diContainer = DIContainer();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late QuestBloc _questBloc;
  late String userId;

  @override
  void initState() {
    super.initState();
    _questBloc = BlocProvider.of<QuestBloc>(context);
    userId = widget.authUserModel.userId;
  }

  void clearText() {
    _questionController.clear();
    _choice1Controller.clear();
    _choice2Controller.clear();
    _choice3Controller.clear();
    _correctController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<QuestBloc, QuestState>(
        bloc: _questBloc,
        listener: _addListener,
        builder: (context, state) {
          if (state.stateStatus == StateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Container(
              color: canvasColor,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      width: 450,
                      height: screenSize.height / 1,
                      decoration: BoxDecoration(
                          color: canvasColor,
                          borderRadius: BorderRadius.circular(20)),
                      // color: canvasColor,
                      alignment: Alignment.center,

                      child: Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: screenSize.height / 4,
                                  child: Container(
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
                                    // color: textColor,
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: canvasColor,
                                            overflow: TextOverflow.visible,
                                            fontSize: textSize),
                                        controller: _questionController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        decoration: const InputDecoration(
                                            // prefixIcon: Icon(
                                            //   Icons.email_outlined,
                                            //   color: textColor,
                                            // ),
                                            border: InputBorder.none,
                                            hintText: "Enter Question",
                                            hintStyle: TextStyle(
                                                color: canvasColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: textSize)),
                                        validator: (String? val) {
                                          return Guard.againstEmptyString(
                                              val, 'Question');
                                        }),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Choices:',
                                    style: TextStyle(
                                        color: textColor, fontSize: 15),
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Container(
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
                                    // color: textColor,
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: canvasColor,
                                            overflow: TextOverflow.visible,
                                            fontSize: textSize),
                                        controller: _choice1Controller,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                            // prefixIcon: Icon(
                                            //   Icons.email_outlined,
                                            //   color: textColor,
                                            // ),
                                            border: InputBorder.none,
                                            hintText: "Choice 1",
                                            hintStyle: TextStyle(
                                                color: canvasColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: textSize)),
                                        validator: (String? val) {
                                          return Guard.againstEmptyString(
                                              val, 'Choice 1');
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Container(
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
                                    // color: textColor,
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: canvasColor,
                                            overflow: TextOverflow.visible,
                                            fontSize: textSize),
                                        controller: _choice2Controller,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Choice 2",
                                            hintStyle: TextStyle(
                                                color: canvasColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: textSize)),
                                        validator: (String? val) {
                                          return Guard.againstEmptyString(
                                              val, 'Choice 2');
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Container(
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
                                    // color: textColor,
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: canvasColor,
                                            overflow: TextOverflow.visible,
                                            fontSize: textSize),
                                        controller: _choice3Controller,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Choice 3",
                                            hintStyle: TextStyle(
                                                color: canvasColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: textSize)),
                                        validator: (String? val) {
                                          return Guard.againstEmptyString(
                                              val, 'Choice 3');
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Container(
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
                                    // color: textColor,
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: canvasColor,
                                            overflow: TextOverflow.visible,
                                            fontSize: textSize),
                                        controller: _correctController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Correct Answer",
                                            hintStyle: TextStyle(
                                                color: canvasColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: textSize)),
                                        validator: (String? val) {
                                          return Guard.againstEmptyString(
                                              val, 'Correct Answer');
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 100,
                                          child: FloatingActionButton(
                                            heroTag: 'f1',
                                            backgroundColor: textColor,
                                            onPressed: () {
                                              _addQuest(context);
                                            },
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: canvasColor,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 100,
                                          child: FloatingActionButton(
                                            heroTag: 'f2',
                                            backgroundColor: textColor,
                                            onPressed: () {
                                              clearText();
                                            },
                                            child: const Text(
                                              'Clear',
                                              style: TextStyle(
                                                  color: canvasColor,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _addQuest(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _questBloc.add(
        AddQuestEvent(
          addquestModel: AddQuestModel(
              question: _questionController.text,
              choice1: _choice1Controller.text,
              choice2: _choice2Controller.text,
              choice3: _choice3Controller.text,
              choice4: _correctController.text,
              questId: userId),
        ),
      );
      
    }
  }

  void _addListener(BuildContext context, QuestState state) {
    if (state.stateStatus == StateStatus.error) {
      SnackBarUtils.defualtSnackBar('Something went wrong!', context);
      clearText();
    }
    if (state.isAdded == true) {
      SnackBarUtils.defualtSnackBar('Question Added!', context);
      clearText();
    }
  }
}

const textColor = Colors.white70;
const canvasColor = Color.fromARGB(255, 33, 32, 75);
const bodyColor = Colors.black12;
const hoverColor = Color.fromARGB(255, 108, 107, 136);
const double textSize = 20;
const double iconSize = 30;
