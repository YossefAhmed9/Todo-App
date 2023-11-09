import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components.dart';
import '../../cubit/TodoCubit.dart';
import '../../cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var TaskTitleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var timekey = GlobalKey<FormState>();
  var dateKey = GlobalKey<FormState>();

//DateTime date=DateTime.parse;
  String formattedDate = DateFormat.yMMMEd().format(DateTime.now());

  @override
  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    // final appCubit=AppCubit.get(context);

    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if (state is AppInsertInDatabase) {
              Navigator.popUntil(context, (newTasks) => true);
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'New Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_all_outlined), label: 'Done Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined),
                      label: 'Archived Tasks'),
                ],
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                },
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDataLoading,
                builder: (context) =>
                    AppCubit.get(context).screen[cubit.currentIndex],
                fallback: (context) {
                  return Center(child: (CircularProgressIndicator()));
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet((context) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.brown[200],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: defaultTextFormField(
                                          // formKey,
                                          TextInputType.text,
                                          TaskTitleController,
                                          (value) => print(value),
                                          (value) => print(value),
                                          () {},
                                          'Enter task name',
                                          OutlineInputBorder(),
                                          Icon(Icons.task_alt),
                                          (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Enter task title';
                                        } else {
                                          TaskTitleController.text =
                                              value.toString();
                                          return null;
                                        }
                                      }),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: defaultTextFormField(
                                                // dateKey,
                                                TextInputType.none,
                                                dateController,
                                                (value) {
                                                  print(value);
                                                },
                                                (value) {
                                                  print(value);
                                                },
                                                () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate:
                                                        DateTime(2000, 1, 1),
                                                    lastDate:
                                                        DateTime(2040, 12, 31),
                                                  ).then((value) {
                                                    dateController.text =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(value!)
                                                            .toString();
                                                    print(dateController);
                                                  });
                                                  ((value) {
                                                    print(
                                                        value?.format(context));
                                                  });
                                                },
                                                'task date',
                                                OutlineInputBorder(),
                                                Icon(Icons
                                                    .calendar_month_rounded),
                                                (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter task date';
                                                  } else {
                                                    return null;
                                                  }
                                                }),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: defaultTextFormField(
                                                // timekey,
                                                TextInputType.none,
                                                timeController,
                                                (value) {
                                                  print(value);
                                                },
                                                (value) {
                                                  print(value);
                                                },
                                                () {
                                                  showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now())
                                                      .then((value) {
                                                    print(value
                                                        ?.format(context)
                                                        .toString());
                                                    timeController.text = (value
                                                        ?.format(context)
                                                        .toString())!;
                                                    print(timeController);
                                                  });
                                                },
                                                'task time',
                                                OutlineInputBorder(),
                                                Icon(Icons.timer_sharp),
                                                (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter task time';
                                                  } else {
                                                    return null;
                                                  }
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  //Default Button
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: defaultButton(100, 50, Colors.red,
                                          () async {
                                        if (formKey.currentState!.validate()) {
                                          try {
                                            await cubit.insertToDatabase(
                                              title: TaskTitleController.text,
                                              date: dateController.text,
                                              time: timeController.text,
                                            );
                                          } catch (error) {
                                            print(
                                                'error is $error.runtimeType');
                                          }

                                          print('title= $TaskTitleController'
                                              .toString());
                                          print('title= $timeController'
                                              .toString());
                                          print('title= $dateController'
                                              .toString());
                                          return 'Enter task name';
                                        }

                                        return null;
                                      }, 'Done', Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                        .closed
                        .then((value) {
                          if (cubit.isBottomSheetShown) {
                          } else {}
                        });
                  }
                },
                child: cubit.fabIcon,
              ),
            );
          },
        ));
  }

/*
*
*   setState(() {
              floatButton = Icon(Icons.edit);
            });
* */
}
