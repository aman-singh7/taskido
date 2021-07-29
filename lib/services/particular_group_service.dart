import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/participant_model.dart';

class ParticularGroupService {
  final _firestore = locator<FirebaseFirestore>();

  Stream<QuerySnapshot> getNotification(String id) {
    return _firestore
        .collection('Groups')
        .doc(id)
        .collection('Notifications')
        .snapshots();
  }

  Future<bool> deleteNotification(String groupid, String docid) async {
    try {
      var result;
      await _firestore
          .collection('Groups')
          .doc(groupid)
          .collection('Notifications')
          .doc(docid)
          .delete()
          .then((value) => result = true)
          .catchError((err) => result = false);
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<Participant>> getParticipants(String groupId) async {
    var res = <Participant>[];
    try {
      var participants = await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('Participants')
          .get();
      participants.docs.forEach((element) {
        res.add(Participant(element['name'], element['email']));
      });
    } catch (e) {
      print(e.toString());
    }

    return res;
  }

  Future<String?> createNotification(String title, String description,
      DateTime time, String groupId, bool isImportant) async {
    try {
      await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('Notifications')
          .add({
        'title': title,
        'description': description,
        'isImportant': isImportant,
        'time': Timestamp.fromDate(time),
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
