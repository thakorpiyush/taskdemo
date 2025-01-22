import 'package:demoproject/src/app/model/task_model.dart';
import 'package:demoproject/src/app/viewmodel/task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomClass{
  void editTask(BuildContext context, WidgetRef ref, {TaskModel? item,String? insertStatus}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController =
    TextEditingController(text: item?.description ?? '');
    final statusController = TextEditingController(text: item?.status ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(insertStatus == "insert" ? 'Add Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description')),
              TextField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: 'Status')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newItem = TaskModel(
                    id: item?.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    createdAt: DateTime.now().toString(),
                    status: statusController.text);
                if (insertStatus == "insert") {
                  ref.read(taskViewModelProvider.notifier).addItem(newItem);
                } else {
                  ref.read(taskViewModelProvider.notifier).updateItem(newItem);
                }
                Navigator.of(context).pop();
              },
              child:  Text(insertStatus == "insert"? 'Save':'Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(BuildContext context, WidgetRef ref, {TaskModel? item}) {

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Are you sure you want to delete ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(taskViewModelProvider.notifier)
                      .deleteItem(item?.id ?? 0);
                  Navigator.pop(context, true);

                }, // passing true
                child: const Text('Yes'),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }
}