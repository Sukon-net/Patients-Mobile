import 'package:bloc/bloc.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/features/payment/data/repo/payment_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo _paymentRepo;

  PaymentCubit(this._paymentRepo) : super(const PaymentState());

  Future<void> getWalletBalance() async {
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _paymentRepo.getWalletBalance();
    result.fold(
      (failure) => emit(state.copyWith(
          status: PaymentStatus.error, errorMessage: failure.message)),
      (success) => emit(
          state.copyWith(status: PaymentStatus.loaded, walletBalance: success)),
    );
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(selectedPaymentMethod: paymentMethod));
  }

  Future<void> processPayment(double amount) async {
    emit(state.copyWith(status: PaymentStatus.processing));
    if (state.selectedPaymentMethod == PaymentMethod.sukonWallet) {
      final balance = state.walletBalance;
      if (balance < amount) {
        emit(state.copyWith(
            status: PaymentStatus.error,
            errorMessage: LocaleKeys.insufficient_balance.tr()));
        return;
      } else {
        emit(state.copyWith(status: PaymentStatus.success));
      }
      return;
    }

    // For credit card payment, get iframe URL
    final result = await _paymentRepo.getPaymentIframeUrl(amount);
    result.fold(
      (failure) => emit(state.copyWith(
        status: PaymentStatus.error,
        errorMessage: failure.message,
      )),
      (iframeUrl) => emit(state.copyWith(
        status: PaymentStatus.showingIframe,
        iframeUrl: iframeUrl,
      )),
    );
  }

  void onPaymentSuccess() {
    emit(state.copyWith(status: PaymentStatus.success));
  }

  void onPaymentFailed(String errorMessage) {
    emit(state.copyWith(
      status: PaymentStatus.error,
      errorMessage: errorMessage,
    ));
  }

  void resetErrors() {
    emit(state.copyWith(
      status: PaymentStatus.loaded,
      errorMessage: '',
    ));
  }
}
