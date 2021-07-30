import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/routine_model.dart';

class RoutineService {
  final _firestore = locator<FirebaseFirestore>();

  Future<List<Routine>> getRoutines(String groupId, String day) async {
    var result = <Routine>[];

    try {
      var docs = await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('Schedule $day')
          .get();
      docs.docs.forEach((element) {
        result.add(Routine(
          id: element.id,
          name: element['name'],
          from: element['from'],
          to: element['to'],
          compare: element['compare'],
          remark: element['remark'],
        ));
      });
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<Routine?> addRoutine(
    String name,
    DateTime from,
    DateTime to,
    String remark,
    String groupId,
    String day,
  ) async {
    try {
      var result = await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('Schedule $day')
          .add({
        'name': name,
        'from': DateFormat.jm().format(from),
        'to': DateFormat.jm().format(to),
        'compare': DateFormat.Hm().format(from),
        'remark': remark,
      });

      var routine = Routine(
        id: result.id,
        name: name,
        from: DateFormat.jm().format(from),
        to: DateFormat.jm().format(to),
        compare: DateFormat.Hm().format(from),
        remark: remark,
      );
      return routine;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> deleteRoutine(String docId, String groupId, String day) async {
    try {
      var result;
      await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('Schedule $day')
          .doc(docId)
          .delete()
          .then((value) => result = true)
          .catchError((err) => result = false);
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
