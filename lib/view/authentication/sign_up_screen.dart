
import 'package:shopping_demo/utils/imports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String email = "";
  String password = "";
  String confirmPassword = "";
  SignUpController signUpController = Get.put(SignUpController());
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
          PasswordTextFieldWidget(
              hint: 'Confirm Password',
              errorMsg: 'Password is Required',
              inputType: TextInputType.visiblePassword,
              returnFunValue: (String value) {
                confirmPassword = value;
              }),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have Account?"),
              GestureDetector(
                onTap: (){
                  Get.to(SignInScreen());
                },
                child: Text(" Login",style: AppTextStyles.appTextStyle(color: Colors.red),),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          ElevatedButton(
              onPressed: (){
                validateAndSignUp();
              },
              child: const Text("SignUp"),
          ),
          // Spacer(),
        ],
      ),
    );
  }

  void validateAndSignUp() {

    isLoading = true;
    setState(() {});
    bool isValidEmail = (email!='' && email.length>=6);
    bool isValidPassword = (password!='' && password.length > 6 && password==confirmPassword);

    if(isValidEmail == true && isValidPassword == true){
      signUpController.registerUser(context,email, password).then((value){
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
