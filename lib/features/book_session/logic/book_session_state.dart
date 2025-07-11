part of 'book_session_cubit.dart';

enum AvailableDaysStatues {
  initial,
  loading,
  success,
  error,
}

enum AvailableSlotsStatues {
  initial,
  loading,
  success,
  error,
}

enum BookSessionStatus {
  initial,
  loading,
  success,
  error,
}

class BookSessionState extends Equatable {
  const BookSessionState({
    this.availableDaysStatus = AvailableDaysStatues.initial,
    this.availableSlotsStatus = AvailableSlotsStatues.initial,
    this.errorMessage = "",
    this.availableDays,
    this.selectedDate,
    this.selectedDuration,
    this.availableSlots,
    this.selectedSlot,
    this.status = BookSessionStatus.initial,
  });

  final AvailableDaysStatues availableDaysStatus;
  final AvailableSlotsStatues availableSlotsStatus;
  final String errorMessage;
  final List<String>? availableDays;
  final DateTime? selectedDate;
  final String? selectedDuration;
  final List<TimeRange>? availableSlots;
  final String? selectedSlot;
  final BookSessionStatus status;
  @override
  List<Object?> get props => [
        availableSlotsStatus,
        availableDaysStatus,
        errorMessage,
        availableDays,
        selectedDate,
        selectedDuration,
        availableSlots,
        selectedSlot,
        status,
      ];

  BookSessionState copyWith(
      {AvailableDaysStatues? availableDaysStatus,
      AvailableSlotsStatues? availableSlotsStatus,
      String? errorMessage,
      List<String>? availableDays,
      DateTime? selectedDate,
      String? selectedDuration,
      List<TimeRange>? availableSlots,
      String? selectedSlot,
      BookSessionStatus? status}) {
    return BookSessionState(
      availableDaysStatus: availableDaysStatus ?? this.availableDaysStatus,
      availableSlotsStatus: availableSlotsStatus ?? this.availableSlotsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      availableDays: availableDays ?? this.availableDays,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      availableSlots: availableSlots ?? this.availableSlots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      status: status ?? this.status,
    );
  }
}
