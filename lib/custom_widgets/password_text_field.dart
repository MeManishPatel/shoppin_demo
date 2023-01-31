
import 'package:shopping_demo/utils/imports.dart';

class PasswordTextFieldWidget extends StatefulWidget {

  final Function(String ans) returnFunValue;
  final index;
  final answer;
  final hint;
  final errorMsg;
  final inputType;
  final initialValue;

  const PasswordTextFieldWidget(
      {Key? key,
        this.index,
        this.answer,
        this.hint,
        this.errorMsg,
        this.inputType,
        this.initialValue,
        required this.returnFunValue})
      : super(key: key);

  @override
  _PasswordTextFieldWidgetState createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            child: TextFormField(
              //initialValue: initialValue,
              textInputAction: TextInputAction.done,
              style: const TextStyle(color: AppColors.colorTextField,fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
              keyboardType: widget.inputType??TextInputType.text,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                hintText: widget.hint,
                contentPadding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL,right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent)),
                errorStyle:
                AppTextStyles.appTextStyle(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.red),
                fillColor: Colors.transparent,
                filled: true,
                suffixIcon: InkWell(
                  onTap: () => setState(
                        () => passwordVisibility = !passwordVisibility,
                  ),
                  child: Icon(
                    passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.colorTextField,
                    size: 24,
                  ),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                  errorText: widget.errorMsg),
              onChanged: (value) {
                return widget.returnFunValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
