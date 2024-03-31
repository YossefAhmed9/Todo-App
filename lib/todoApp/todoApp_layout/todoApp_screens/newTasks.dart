import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/TodoCubit.dart';
import '../../../cubit/states.dart';

class NewTasks extends StatelessWidget {
  // NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        AppCubit cubit = AppCubit.get(context);

        Widget BuildNewTask(Map model) => Dismissible(
              key: Key(model['id'].toString()),
              onDismissed: (direction) {
                AppCubit.get(context).deleteData(id: model['id']);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                      child: Text(
                        '${model['time']} ',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${model['title']}',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightGreenAccent),
                        ),
                        Text(
                          '${model['date']}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.pinkAccent),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.updateData(
                            status: 'done',
                            id: model['id'],
                          );
                        },
                        icon: const Icon(Icons.check_circle),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.updateData(
                            status: 'archive',
                            id: model['id'],
                          );
                        },
                        icon: const Icon(Icons.archive),
                        color: Colors.red[700],
                      ),
                    ],
                  )
                ],
              ),
            );

        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => BuildNewTask(tasks[index]),
            separatorBuilder: (context, index) => (Container(
              width: double.infinity,
              color: Colors.grey,
              height: 1,
            )),
            itemCount: tasks.length,
          ),
          fallback: (context) =>  Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_outlined, size: 100, color: Colors.pink),
                  Text(
                    'Enter new tasks and start working!',
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
