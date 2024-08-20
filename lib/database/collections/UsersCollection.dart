import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app_c11/database/models/app_user.dart';

class UsersCollection {

  CollectionReference<AppUser> getUsersCollection() {
    var db = FirebaseFirestore.instance;

    return db.collection("users").withConverter(
        fromFirestore: (snapshot, options) {
      return AppUser.fromFireStore(snapshot.data());
    }, toFirestore: (obj, options) {
      return obj.toFireStore();
    });
  }

  Future<void> createUser(AppUser user)  {
    //write user in users collection
    return getUsersCollection().doc(user.authId).set(user);
  }

  Future<AppUser?> readUser(String uid) async{
    var docSnapshot=await getUsersCollection().doc(uid).get();
    return docSnapshot.data();
  }
}
