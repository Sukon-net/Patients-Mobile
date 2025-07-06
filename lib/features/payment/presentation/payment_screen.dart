import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/toastifications.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/payment/logic/payment_cubit.dart';
import 'package:clients/features/payment/presentation/widgets/payment_iframe_widget.dart';
import 'package:clients/features/payment/presentation/widgets/payment_method_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreenArguments {
  final double amount;
  final bool shouldShowSukonWallet;

  const PaymentScreenArguments({
    required this.amount,
    this.shouldShowSukonWallet = true,
  });
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.arguments});

  final PaymentScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;
    context.read<PaymentCubit>().getWalletBalance();

    return Scaffold(
      appBar: TopAppBar(
        widget: Text(
          context.tr(LocaleKeys.payment),
          style: TextStyles.size24Weight600.copyWith(
            color: context.colors.primaryTextColor,
          ),
        ),
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.status == PaymentStatus.success) {
            NavigatorService.pop(returnValue: true);
          } else if (state.status == PaymentStatus.error ||
              state.status == PaymentStatus.fetalError) {
            Toastifications.show(
              context: context,
              message: state.errorMessage,
              textColor: textColor,
              borderColor: borderColor,
              backgroundColor: backgroundColor,
            );
            context.read<PaymentCubit>().resetErrors();
            if (state.status == PaymentStatus.fetalError) {
              NavigatorService.pop(returnValue: false);
            }
          }
        },
        builder: (context, state) {
          if (state.status == PaymentStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Show iframe when payment is being processed via credit card
          if (state.status == PaymentStatus.showingIframe) {
            return PaymentIframeWidget(
              iframeUrl: state.iframeUrl,
              onPaymentSuccess: () {
                context.read<PaymentCubit>().onPaymentSuccess();
              },
              onPaymentFailed: (errorMessage) {
                context.read<PaymentCubit>().onPaymentFailed(errorMessage);
              },
            );
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                spacing: 12.h,
                children: [
                  PaymentMethodTile(
                    title: context.tr(LocaleKeys.credit_card),
                    subtitle: context.tr(LocaleKeys.add_new_card),
                    icon: Assets.assetsIconsCard,
                    isSelected:
                        state.selectedPaymentMethod == PaymentMethod.creditCard,
                    onTap: () {
                      context
                          .read<PaymentCubit>()
                          .selectPaymentMethod(PaymentMethod.creditCard);
                    },
                  ),
                  if (arguments.shouldShowSukonWallet)
                    PaymentMethodTile(
                      title: context.tr(LocaleKeys.sukon_wallet),
                      subtitle:
                          "${state.walletBalance} ${context.tr(LocaleKeys.egp)}",
                      icon: Assets.assetsIconsWallet,
                      isSelected: state.selectedPaymentMethod ==
                          PaymentMethod.sukonWallet,
                      onTap: () {
                        context
                            .read<PaymentCubit>()
                            .selectPaymentMethod(PaymentMethod.sukonWallet);
                      },
                    ),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      backgroundColor: context.colors.primaryCTAColor,
                      foregroundColor: context.colors.onPrimaryCTAColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: state.status == PaymentStatus.processing
                        ? null
                        : () {
                            context
                                .read<PaymentCubit>()
                                .processPayment(arguments.amount);
                          },
                    child: state.status == PaymentStatus.processing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.selectedPaymentMethod ==
                                        PaymentMethod.creditCard
                                    ? context.tr(LocaleKeys.pay)
                                    : context.tr(LocaleKeys.pay_now),
                                style: TextStyles.size16Weight500,
                              ),
                              Text(
                                "${arguments.amount} ${context.tr(LocaleKeys.egp)}",
                                style: TextStyles.size16Weight500,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
