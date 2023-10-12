// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  static const String collectionName = "tasks";
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  TaskModel.fromFireStore(Map<String, dynamic> fireStoreData)
      : this(
          id: fireStoreData["id"] as String?,
          title: fireStoreData["title"] as String?,
          description: fireStoreData["description"] as String?,
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(fireStoreData["dateTime"]),
          isDone: fireStoreData["isDone"],
        );
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
