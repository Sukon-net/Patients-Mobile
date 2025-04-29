part of '../otp_screen.dart';

class _OtpWidget extends StatelessWidget {
  final void Function(String) onCompleted;
  final void Function(String) onChanged;
  final String? errorMessage;
  final TextEditingController? controller;

  const _OtpWidget({
    required this.onCompleted,
    required this.onChanged,
    this.errorMessage,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      crossAxisAlignment: CrossAxisAlignment.start,
      onCompleted: onCompleted,
      onChanged: onChanged,
      length: 4,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      forceErrorState: errorMessage != null,
      errorText: errorMessage,
      defaultPinTheme: PinTheme(
        height: 48.h,
        textStyle: TextStyles.size18Weight600.copyWith(
          color: context.colors.primaryTextColor,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.borderColor,
            width: 1.r,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),

      ///handel focused///
      focusedPinTheme: PinTheme(
        height: 48.h,
        textStyle: TextStyles.size18Weight600.copyWith(
          color: context.colors.primaryTextColor,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.primaryCTAColor,
            width: 2.r,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),

      ///handel error///
      errorPinTheme: PinTheme(
        height: 48.h,
        textStyle: TextStyles.size18Weight600.copyWith(
          color: context.colors.primaryTextColor,
        ),
        decoration: BoxDecoration(
          color: context.colors.errorAccentColor,
          border: Border.all(
            color: context.colors.errorColor,
            width: 2.r,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      errorTextStyle: TextStyles.size14Weight400.copyWith(
        color: context.colors.errorColor,
      ),
    );
  }
}
