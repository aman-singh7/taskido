import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/participant_model.dart';
import 'package:task_dot_do/services/push_notification.dart';

class ParticularGroupService {
  final _firestore = locator<FirebaseFirestore>();
  final _pushNotification = locator<PushNotification>();

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

  Future<String?> getToken(String email) async {
    try {
      var response = await _firestore.collection('Users').doc(email).get();
      return response['token'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> createNotification(String title, String description,
      DateTime time, String groupId, String groupName, bool isImportant) async {
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
      var participants = await getParticipants(groupId);
      var tokens = <String>[];
      for (var participant in participants) {
        var res = await getToken(participant.email);
        if (res != null) tokens.add(res);
      }
      await _pushNotification.sendFCM(tokens, groupName, title);
    } catch (e) {
      print(e.toString());
    }
  }
}
