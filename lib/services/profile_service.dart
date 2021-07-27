import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/models/person_model.dart';

class ProfileService {
  var authService = locator<FirebaseAuth>();
  var firestore = locator<FirebaseFirestore>();

  Future<Person?> getInformation() async {
    var email = authService.currentUser!.email;
    try {
      var response = await firestore.collection('Users').doc(email).get();
      var person = Person(
        email: email!,
        name: response['name'],
        phone: response['phone'],
        enrollment: response['enrollment'],
      );
      return person;
    } catch (e) {
      print(e.toString());
    }
  }
}
