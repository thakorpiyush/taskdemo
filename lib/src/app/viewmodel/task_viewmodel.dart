import 'package:demoproject/src/app/model/task_model.dart';
import 'package:demoproject/src/services/sqlite_manager/task_repositery.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskViewmodel extends StateNotifier<List<TaskModel>> {
  final TaskRepositery _repository;
  String _searchQuery = '';
  String? selectedFilter; // Filter value state

  TaskViewmodel(this._repository) : super([]) {
    loadItems();
  }

  Future<void> loadItems() async {
    final items = await _repository.fetchItems();
    _applyFilter(items);
  }

  Future<void> addItem(TaskModel item) async {
    await _repository.addItem(item);
    loadItems();
  }

  Future<void> updateItem(TaskModel item) async {
    await _repository.updateItem(item);
    loadItems();
  }

  Future<void> deleteItem(int id) async {
    await _repository.deleteItem(id);
    loadItems();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilter(state);
  }

  void updateSelectedFilter(String? filter) {
    selectedFilter = filter;
    _applyFilter(state);
  }

  void _applyFilter(List<TaskModel> items) {
    var filteredItems = items;

    if (selectedFilter != null) {
      if(selectedFilter!.isNotEmpty){
        filteredItems = filteredItems
            .where((item) => item.status!.contains(selectedFilter!))
            .toList();
      }else{
        filteredItems = items;
      }
    }

    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where((item) =>
      item.title!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    filteredItems.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createdAt!);
      DateTime dateB = DateTime.parse(b.createdAt!);
      return dateA.compareTo(dateB); // Ascending order
    });

    state = filteredItems;
  }
}

// Provider for ItemRepository
final taskRepositoryProvider = Provider((ref) => TaskRepositery());

// Provider for ItemViewModel
final taskViewModelProvider =
    StateNotifierProvider<TaskViewmodel, List<TaskModel>>(
  (ref) {
    final repository = ref.watch(taskRepositoryProvider);
    return TaskViewmodel(repository);
  },
);
