import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/components.dart';
import '../../cubit/TodoCubit.dart';
import '../../cubit/states.dart';
import '../../widgets/floating_icon_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  TextEditingController TaskTitleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> timekey = GlobalKey<FormState>();
  GlobalKey<FormState> dateKey = GlobalKey<FormState>();

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
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).currentIndex,
                items: const [
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
                  return const Center(child: (CircularProgressIndicator()));
                },
              ),
              floatingActionButton:FloatingIconButton()
            );
          },
        ));
  }


}
