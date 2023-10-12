import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseServices {
  static CollectionReference<TaskModel> initCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapShot, options) {
        return TaskModel.fromFireStore(snapShot.data()!);
      },
      toFirestore: (taskModel, options) {
        return taskModel.toFireStore();
      },
    );
  }

  static Future<List<QueryDocumentSnapshot<TaskModel>>>
      getTasksFromFireStore() async {
    var querySnapshot = await FirebaseServices.initCollection().get();
    return querySnapshot.docs;
  }

  static Future<void> addTaskToFirebase(TaskModel task) async {
    var taskCollection = initCollection(); // get/create collection(Class)
    var taskDocument =
        taskCollection.doc(); // create document(Object) with random ID
    task.id = taskDocument.id; // We get the auto generated id
    return await taskDocument.set(task);
  }

  static Future<void> deleteTaskFromFireStore(String id) async {
    await initCollection().doc(id).delete();
  }

  static Future<void> updateTaskInFireStore(String id, TaskModel task) async {
    await FirebaseServices.initCollection().doc(id).update({
      "title": task.title,
      "description": task.description,
      "dateTime": task.dateTime?.millisecondsSinceEpoch,
    });
  }

  static Future<void> markAsDoneInFireStore(String id) async {
    await FirebaseServices.initCollection().doc(id).update({"isDone": true});
  }
}
