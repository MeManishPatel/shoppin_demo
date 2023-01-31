import '../../utils/imports.dart';

class SignInController extends GetxController {

  AuthenticationRepository authenticationRepository = Get.put(AuthenticationRepository());

  Future<UserCredential?> loginUser(BuildContext context,String email, String password) async {
    UserCredential? result = await authenticationRepository.loginWithEmailAndPassword(context,email, password);
    return result;
  }
}