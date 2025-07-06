// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_cubit.dart';

enum PaymentStatus {
  loading,
  loaded,
  success,
  processing,
  error,
  fetalError,
  showingIframe,
}

enum PaymentMethod {
  creditCard,
  sukonWallet,
}

class PaymentState extends Equatable {
  const PaymentState({
    this.status = PaymentStatus.loading,
    this.selectedPaymentMethod = PaymentMethod.creditCard,
    this.walletBalance = 0,
    this.errorMessage = '',
    this.iframeUrl = '',
  });

  final PaymentStatus status;
  final PaymentMethod selectedPaymentMethod;
  final double walletBalance;
  final String errorMessage;
  final String iframeUrl;

  @override
  List<Object> get props =>
      [selectedPaymentMethod, status, walletBalance, errorMessage, iframeUrl];

  PaymentState copyWith({
    PaymentStatus? status,
    PaymentMethod? selectedPaymentMethod,
    double? walletBalance,
    String? errorMessage,
    String? iframeUrl,
  }) {
    return PaymentState(
      status: status ?? this.status,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      walletBalance: walletBalance ?? this.walletBalance,
      errorMessage: errorMessage ?? this.errorMessage,
      iframeUrl: iframeUrl ?? this.iframeUrl,
    );
  }
}
