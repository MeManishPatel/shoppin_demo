
import '../utils/imports.dart';

class TextFieldWidget extends StatelessWidget {

  final Function(String ans) returnFunValue;
  final index;
  final answer;
  final hint;
  final errorMsg;
  final inputType;
  final isMultiLine;
  final leading;
  final initialValue;

  const TextFieldWidget(
      {Key? key,
        this.index,
        this.answer,
        this.hint,
        this.errorMsg,
        this.inputType,
        this.isMultiLine,
        this.leading,
        this.initialValue,
        required this.returnFunValue})
      : super(key: key);

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
              initialValue: initialValue,
              textInputAction: TextInputAction.done,
              style: const TextStyle(color: AppColors.colorTextField,fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
              keyboardType: inputType??TextInputType.text,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL,right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent)),
                errorStyle:
                AppTextStyles.appTextStyle(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.red),
                fillColor: Colors.transparent,
                filled: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
                FormBuilderValidators.max(70),
              ]),
              onChanged: (value) {
                return returnFunValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
