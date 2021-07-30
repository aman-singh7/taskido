import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();

  ///FireStore Database
  //addUser to db while regisetring
  Future<void> addUser(String email, String name, String phone) async {
    await _firestore
        .collection('Users')
        .doc(email)
        .set({
          'Name': name,
          'Phone no.': phone,
        })
        .then((value) => print('User registered Succesfully'))
        .catchError((e) => throw e);
    return;
  }

  ///LocalStorage Database
  // add Task to shared prefernece

  Future<String> addTask(String date, Task task) async {
    DocumentReference doc = await _firestore
        .collection('Users')
        .doc('aman@gmail.com')
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .add(task.toJson());
    return doc.id;
  }

  // Future<Map<String, List<Task>>> getTaskMap() async {
  //   var email = _firebaseAuthService.currentUser.email!;
  //   var docSnapshot = await _firestore
  //       .collection('Users')
  //       .doc(email)
  //       .collection('tasks')
  //       .get();

  //   var map = <String, List<Task>>{};
  //   docSnapshot.docs.forEach((doc) async {
  //     map.addAll({doc.id: await getTasks(doc.id)});
  //   });
  //   return map;
  // }

  // Future<List<Task>> getTasks(String date) async {
  //   var email = _firebaseAuthService.currentUser.email!;
  //   var docList = await _firestore
  //       .collection('Users')
  //       .doc(email)
  //       .collection('tasks')
  //       .doc(date)
  //       .collection('taskList')
  //       .get();

  //   return docList.docs.map((doc) {
  //     var map = doc.data();
  //     map.update('id', (value) => doc.id, ifAbsent: () => doc.id);
  //     return Task.fromJson(map);
  //   }).toList();
  // }

  Future<void> deleteTask(String id, String date) async {
    await _firestore
        .collection('Users')
        .doc('aman@gmail.com')
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .doc(id)
        .delete();
    return;
  }

  Future<void> upDateTask(
      String id, String date, String field, dynamic newValue) async {
    await _firestore
        .collection('Users')
        .doc('aman@gmail.com')
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .doc(id)
        .update({field: newValue});
  }

  Stream<QuerySnapshot> get getDates => _getDates();

  Stream<QuerySnapshot> _getDates() {
    return _firestore
        .collection('Users')
        .doc('aman@gmail.com')
        .collection('tasks')
        .snapshots();
  }

  Stream<List<Task>> getTasksforDate(String date) {
    var snapshot = _firestore
        .collection('Users')
        .doc('aman@gmail.com')
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .snapshots();

    var stream = snapshot
        .map((querySnapshot) => querySnapshot.docs.map((queryDocumentSnapshot) {
              var taskMap = queryDocumentSnapshot.data();
              taskMap.addAll({'id': queryDocumentSnapshot.id});
              return Task.fromJson(taskMap);
            }).toList());
    return stream;
  }

  Stream<Map<String, dynamic>> getTasks() {
    var snapshot =
        _firestore.collection('Users').doc('aman@gmail.com').snapshots();
    return snapshot.map((doc) => doc.data()!['tasks'] ?? {})
        as Stream<Map<String, dynamic>>;
  }
}
