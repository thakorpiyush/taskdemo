import 'package:demoproject/src/app/view/task_list_widget.dart';
import 'package:demoproject/src/app/viewmodel/task_viewmodel.dart';
import 'package:demoproject/src/utils/custom_class.dart';
import 'package:demoproject/src/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScreen extends ConsumerWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(taskViewModelProvider);
    final viewModel = ref.read(taskViewModelProvider.notifier);
    final filterOptions = ['Completed', 'Pending'];
    final isDarkTheme = ref.watch(themeProvider) == darkTheme;
    return Scaffold(
        appBar: AppBar(centerTitle: true,
            title: const Text("Task screen")),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Theme: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Switch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(onTap: () => CustomClass().editTask(context, ref, insertStatus: "insert"), child: Container(padding:EdgeInsets.all(8),   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),child: Text("Add Task"))),
              ),

            ],),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        viewModel.selectedFilter = null;
                        if (value.isNotEmpty) {
                          viewModel.updateSearchQuery(value);
                        } else {
                          viewModel.loadItems();
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    value: viewModel.selectedFilter,
                    hint: const Text('Filter'),
                    items: filterOptions
                        .map((filter) => DropdownMenuItem(
                              value: filter,
                              child: Text(filter),
                            ))
                        .toList(),
                    onChanged: (value) {
                      viewModel.loadItems();
                      if (value != null && value.isNotEmpty) {
                        viewModel.updateSelectedFilter(value);
                      } else {
                        viewModel.loadItems();
                      }
                    },
                  ),
                ),
                SizedBox(width: 8,)
              ],
            ),
            items.isEmpty
                ? const Center(child: Text('No items available'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var taskModel = items[index];
                        return TaskListWidget(
                          taskModel: taskModel,
                          ref: ref,
                        );
                      },
                    ),
                  )
          ],
        ));
  }
}
