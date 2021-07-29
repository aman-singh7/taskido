import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/task_model.dart';
import 'package:task_dot_do/services/firebase_auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  ///FireStore Database
  // addUser to db while regisetring
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
    var email = _firebaseAuthService.currentUser.email!;
    DocumentReference doc = await _firestore
        .collection('Users')
        .doc(email)
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .add(task.toJson());
    return doc.id;
  }

  Future<Map<String, List<Task>>> getTaskMap() async {
    var email = _firebaseAuthService.currentUser.email!;
    var docSnapshot = await _firestore
        .collection('Users')
        .doc(email)
        .collection('tasks')
        .get();

    var map = <String, List<Task>>{};
    docSnapshot.docs.forEach((doc) async {
      map.addAll({doc.id: await getTasks(doc.id)});
    });
    return map;
  }

  Future<List<Task>> getTasks(String date) async {
    var email = _firebaseAuthService.currentUser.email!;
    var docList = await _firestore
        .collection('Users')
        .doc(email)
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .get();

    return docList.docs.map((doc) {
      var map = doc.data();
      map.update('id', (value) => doc.id, ifAbsent: () => doc.id);
      return Task.fromJson(map);
    }).toList();
  }

  Future<void> deleteTask(Task task, String date) async {
    var email = _firebaseAuthService.currentUser.email!;
    await _firestore
        .collection('Users')
        .doc(email)
        .collection('tasks')
        .doc(date)
        .collection('taskList')
        .doc(task.id)
        .delete();
    return;
  }
}
