
import 'package:shopping_demo/utils/imports.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String email = "";
  String password = "";
  SignInController signInController = Get.put(SignInController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
          child: Scaffold(
            body: buildBody(),
          )
      ),
    );
  }

  Widget buildBody() {
    return isLoading?const Center(child: CircularProgressIndicator(),):buildSignUpWidget();
  }



  Widget buildSignUpWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldWidget(
              initialValue: email ,
              hint: 'Enter Email',
              errorMsg: 'Email is Required',
              inputType: TextInputType.emailAddress,
              returnFunValue: (String value){
                email = value;
                setState(() {});
              }),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          PasswordTextFieldWidget(
              hint: 'Enter Password',
              errorMsg: 'Password is Required',
              inputType: TextInputType.visiblePassword,
              returnFunValue: (String value) {
                password = value;
              }),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("New User?"),
              GestureDetector(
                onTap: (){
                  Get.to(const SignUpScreen());
                },
                child: Text(" Register",style: AppTextStyles.appTextStyle(color: Colors.red),),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          ElevatedButton(
            onPressed: (){
              validateAndSignIn();
            },
            child: const Text("Login"),
          ),
          // Spacer(),
        ],
      ),
    );
  }

  void validateAndSignIn() {

    isLoading = true;
    setState(() {});
    bool isValidEmail = (email!='' && email.length>=6);
    bool isValidPassword = (password!='' && password.length > 6 );

    if(isValidEmail && isValidPassword){
      signInController.loginUser(context,email, password).then((value){
        isLoading = false;
        setState(() {});
        print("SignUp Return => ${value.toString()}");
      });
    }else{
      isLoading = false;
      setState(() {});
      const snackBar = SnackBar(content: Text("Enter Valid Email And Password"), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
