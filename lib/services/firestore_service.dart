import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('todos');

  Stream<QuerySnapshot> getTodos() {
    return todoCollection.orderBy('createdAt').snapshots();
  }

  Future<void> addTask(String task) {
    return todoCollection.add({'task': task, 'isCompleted': false, 'createdAt': Timestamp.now()});
  }

  Future<void> deleteTask(String id) {
    return todoCollection.doc(id).delete();
  }
}
