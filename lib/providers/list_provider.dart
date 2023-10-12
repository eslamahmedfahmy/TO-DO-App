import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/firebase_services.dart';

class ListsProvider with ChangeNotifier {
  List<TaskModel> tasksList = [];
  DateTime selectedDate = DateTime.now();
  Future<void> getAllTasks() async {
    // var querySnapshot = await FirebaseServices.initCollection()
    //     .get()
    //     .timeout(const Duration(milliseconds: 50));

    // tasksList =
    //     querySnapshot.docs.map((taskSnapshot) => taskSnapshot.data()).toList();
    // notifyListeners();
    var tasksQuery = await FirebaseServices.getTasksFromFireStore();
    tasksList = tasksQuery.map((taskSnapshot) => taskSnapshot.data()).toList();
    tasksList = tasksList.where((task) {
      if (task.dateTime!.day == selectedDate.day &&
          task.dateTime!.month == selectedDate.month &&
          task.dateTime!.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();
    tasksList.sort((task1, task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await FirebaseServices.addTaskToFirebase(task);
  }

  Future<void> deleteTask(String id) async {
    await FirebaseServices.deleteTaskFromFireStore(id);
  }

  Future<void> updateTask(String id, TaskModel task) async {
    await FirebaseServices.updateTaskInFireStore(id, task);
  }

  Future<void> markAsDone(String id) async {
    await FirebaseServices.markAsDoneInFireStore(id);
  }

  void setNewSelectedDate(DateTime date) {
    selectedDate = date;
  }
}
