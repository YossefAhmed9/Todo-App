import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../cubit/TodoCubit.dart';
import 'components.dart';

class FloatingIconButton extends StatelessWidget {
   FloatingIconButton({Key? key}) : super(key: key);


  TextEditingController fabTaskTitleController = TextEditingController();
  TextEditingController fabTimeController = TextEditingController();
  TextEditingController fabDateController = TextEditingController();

  GlobalKey<ScaffoldState> fabScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> fabFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> fabTimekey = GlobalKey<FormState>();
  GlobalKey<FormState> fabDateKey = GlobalKey<FormState>();

//DateTime date=DateTime.parse;
  String fabFormattedDate = DateFormat.yMMMEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    return FloatingActionButton(
      onPressed: () {
        if (cubit.isBottomSheetShown) {
        } else {
          fabScaffoldKey.currentState
              ?.showBottomSheet((context) {
            return Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF750404),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Form(
                key: fabFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.grey[300],
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: defaultTextFormField(
                          // formKey,
                            TextInputType.text,
                            fabTaskTitleController,
                                (value) => print(value),
                                (value) => print(value),
                                () {},
                            'Enter task name',
                            const OutlineInputBorder(),
                            const Icon(Icons.task_alt),
                                (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter task title';
                              } else {
                                fabTaskTitleController.text =
                                    value.toString();
                                return null;
                              }
                            }),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),

                                color: Colors.grey[300],
                              ),
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              child: defaultTextFormField(
                                // dateKey,
                                  TextInputType.none,
                                  fabDateController,
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
                                      fabDateController.text =
                                          DateFormat('dd/MM/yyyy')
                                              .format(value!)
                                              .toString();
                                      print(fabDateController);
                                    });
                                    ((value) {
                                      print(
                                          value?.format(context));
                                    });
                                  },
                                  'task date',
                                  const OutlineInputBorder(),
                                  const Icon(Icons
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Colors.grey[300],
                              ),
                              clipBehavior:
                              Clip.antiAliasWithSaveLayer,
                              child: defaultTextFormField(
                                // timekey,
                                  TextInputType.none,
                                  fabTimeController,
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
                                      fabTimeController.text = (value
                                          ?.format(context)
                                          .toString())!;
                                      print(fabTimeController);
                                    });
                                  },
                                  'task time',
                                  const OutlineInputBorder(),
                                  const Icon(Icons.timer_sharp),
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

                    //Default Button
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(30)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: defaultButton(100, 50, Colors.red,
                                () async {
                              if (fabFormKey.currentState!.validate()) {
                                try {
                                  await cubit.insertToDatabase(
                                    title: fabTaskTitleController.text,
                                    date: fabDateController.text,
                                    time: fabTimeController.text,
                                  );
                                } catch (error) {
                                  print(
                                      'error is $error.runtimeType');
                                }

                                print('title= $fabTaskTitleController'
                                    .toString());
                                print('title= $fabTimeController'
                                    .toString());
                                print('title= $fabDateController'
                                    .toString());
                                return 'Enter task name';
                              }

                              return null;
                            }, 'Done', Colors.white,18),
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
    );
  }
}
