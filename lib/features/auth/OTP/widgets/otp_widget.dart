part of '../presentation/otp_screen.dart';

class _OtpWidget extends StatelessWidget {
  const _OtpWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (previous, current) =>
          ((current is OtpError && current.otpError != null) ||
              (previous is OtpError && previous.otpError != null)),
      builder: (context, state) {
        return Center(
          child: Pinput(
            crossAxisAlignment: CrossAxisAlignment.start,
            controller: context.read<OtpCubit>().otpController,
            defaultPinTheme: PinTheme(
              width: 76.5.w,
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
              width: 76.5.w,
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
            forceErrorState: state is OtpError,
            errorPinTheme: PinTheme(
              width: 76.5.w,
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
            errorText: state is OtpError ? state.otpError : null,
            errorTextStyle: TextStyles.size14Weight400.copyWith(
              color: context.colors.errorColor,
            ),
          ),
        );
      },
    );
  }
}
