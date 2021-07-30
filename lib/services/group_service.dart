import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/group_model.dart';
import 'package:task_dot_do/services/local_storage_service.dart';

class GroupService {
  final _firestore = locator<FirebaseFirestore>();
  final _localStorage = locator<LocalStorageService>();
  final _firebaseauth = locator<FirebaseAuth>();

  Future<GroupModel?> createGroup(String groupName) async {
    try {
      var result =
          await _firestore.collection('Groups').add({'name': groupName});
      await _firestore
          .collection('Groups')
          .doc(result.id)
          .collection('Participants')
          .add({
        'name': _localStorage.displayName,
        'email': _firebaseauth.currentUser!.email,
      });
      await _firestore
          .collection('Users')
          .doc(_firebaseauth.currentUser!.email)
          .collection('Groups')
          .add({
        'name': groupName,
        'id': result.id,
        'isAdmin': true,
      });
      return GroupModel(name: groupName, id: result.id, isAdmin: true);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<GroupModel?> joinGroup(String id) async {
    try {
      var res = await _firestore.collection('Groups').doc(id).get();
      if (!res.exists) return null;

      await _firestore
          .collection('Groups')
          .doc(id)
          .collection('Participants')
          .add({
        'name': _localStorage.displayName,
        'email': _firebaseauth.currentUser!.email,
      });
      await _firestore
          .collection('Users')
          .doc(_firebaseauth.currentUser!.email)
          .collection('Groups')
          .add({
        'name': res['name'],
        'id': id,
        'isAdmin': false,
      });

      return GroupModel(name: res['name'], id: id, isAdmin: false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GroupModel>> joinedGroups() async {
    var res = <GroupModel>[];

    try {
      var groups = await _firestore
          .collection('Users')
          .doc(_firebaseauth.currentUser!.email)
          .collection('Groups')
          .get();
      groups.docs.forEach((group) {
        res.add(GroupModel(
          name: group['name'],
          id: group['id'],
          isAdmin: group['isAdmin'],
        ));
      });
    } catch (e) {
      print(e.toString());
    }

    return res;
  }
}
