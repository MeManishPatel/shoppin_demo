
import '../../utils/imports.dart';

class AuthenticationRepository extends GetxController {

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const SignInScreen()) : Get.offAll(() => const HomeScreen());
  }

  //FUNC
  Future<UserCredential?> createUserWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(content: Text('The password provided is too weak.'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(content: Text('The account already exists for that email.'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> loginWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackBar = SnackBar(content: Text("No user found for that email."), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logout() async => await _auth.signOut();
}