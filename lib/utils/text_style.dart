
import 'imports.dart';

class AppTextStyles {

  static TextStyle appTextStyle(
      {double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? Dimensions.FONT_SIZE_SMALL,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.buttonTextColor,
    );
  }

}