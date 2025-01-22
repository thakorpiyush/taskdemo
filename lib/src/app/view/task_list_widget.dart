import 'package:demoproject/src/app/model/task_model.dart';
import 'package:demoproject/src/app/viewmodel/task_viewmodel.dart';
import 'package:demoproject/src/utils/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListWidget extends StatelessWidget {
  final TaskModel? taskModel;
  final WidgetRef ref;

  const TaskListWidget({super.key, required this.taskModel, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.green.shade100,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskModel?.title ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          taskModel?.description ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: taskModel?.status == "Completed"
                          ? Colors.red
                          : Colors.green,
                      child: Text(
                        taskModel?.status ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => CustomClass().editTask(context, ref,
                          insertStatus: "", item: taskModel),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.green,
                          child: const Icon(
                            Icons.edit_calendar_rounded,
                            color: Colors.white,
                            size: 15,
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => CustomClass()
                          .deleteTask(context, ref, item: taskModel),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete_forever_sharp,
                            color: Colors.white,
                            size: 15,
                          )),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
