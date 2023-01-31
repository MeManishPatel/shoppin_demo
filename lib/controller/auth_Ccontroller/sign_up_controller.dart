
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/imports.dart';

class SignUpController extends GetxController {
  AuthenticationRepository authenticationRepository = Get.put(AuthenticationRepository());

  Future<UserCredential?> registerUser(String email, String password) async {

    UserCredential? result = await authenticationRepository.createUserWithEmailAndPassword(email, password);
    User? user = result?.user;

    if (user != null) {
      FirebaseFirestore.instance
          .collection(user.uid)
          .doc(user.uid)
          .set({
        "user_id": user.uid,
        "user_email": user.email,
        "user_name": user.displayName,
        "user_phone": user.phoneNumber,
      });
    } else {}
    return result;
  }

  setUser ({required User user}){
    if (user != null) {
      FirebaseFirestore.instance
          .collection(user.uid)
          .doc(user.uid)
          .set({
        "user_id": user.uid,
        "user_email": user.email,
        "user_name": user.displayName,
        "user_phone": user.phoneNumber,
      });
    } else {}
  }

}