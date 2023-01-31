import '../../utils/imports.dart';

class SignInController extends GetxController {

  AuthenticationRepository authenticationRepository = Get.put(AuthenticationRepository());

  Future<UserCredential?> loginUser(String email, String password) async {
    UserCredential? result = await authenticationRepository.loginWithEmailAndPassword(email, password);
    return result;
  }
}