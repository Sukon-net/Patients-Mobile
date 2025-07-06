import 'package:clients/features/book_session/data/repository/book_session_repo.dart';
import 'package:clients/features/book_session/model/time_range.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_session_state.dart';

class BookSessionCubit extends Cubit<BookSessionState> {
  BookSessionCubit(this.doctorId, this._repo) : super(const BookSessionState());

  final int doctorId;
  final BookSessionRepoImpl _repo;
  final TextEditingController complainController = TextEditingController();

  Future<void> getDoctorAvailableDays() async {
    emit(state.copyWith(availableDaysStatus: AvailableDaysStatues.loading));
    final result = await _repo.getDoctorsAvailableDays(doctorId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            availableDaysStatus: AvailableDaysStatues.error,
            errorMessage:
                error.message.isNotEmpty ? error.message : "Unknown Error!",
          ),
        );
      },
      (days) {
        emit(
          state.copyWith(
            availableDaysStatus: AvailableDaysStatues.success,
            availableDays: days,
          ),
        );
      },
    );
  }

  Future<void> getDoctorAvailableSlots() async {
    emit(state.copyWith(availableSlotsStatus: AvailableSlotsStatues.loading));
    final result = await _repo.getDoctorAvailableSlots(
      doctorId,
      DateFormat('yyyy-M-d', 'en').format(state.selectedDate!),
      state.selectedDuration!.split(" ").first,
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            availableSlotsStatus: AvailableSlotsStatues.error,
            errorMessage:
                error.message.isNotEmpty ? error.message : "Unknown Error!",
          ),
        );
      },
      (slots) {
        emit(
          state.copyWith(
            availableSlotsStatus: AvailableSlotsStatues.success,
            availableSlots: slots,
          ),
        );
      },
    );
  }

  void onSelectDate(DateTime date) {
    emit(state.copyWith(
      selectedDate: date,
      selectedSlot: null,
      availableSlots: null,
      availableSlotsStatus: AvailableSlotsStatues.initial,
    ));
  }

  void onSelectDuration(String duration) {
    emit(state.copyWith(
      selectedDuration: duration,
      selectedSlot: null,
      availableSlots: null,
      availableSlotsStatus: AvailableSlotsStatues.initial,
    ));
  }

  void onSelectSlot(String slot) {
    emit(state.copyWith(selectedSlot: slot));
  }

  Future<void> bookSession() async {
    emit(state.copyWith(status: BookSessionStatus.loading));
    final isPM = state.selectedSlot!.split(" ").last == "PM";
    final convertedTimeSlot =
        int.parse(state.selectedSlot!.split(" ").first.split(":")[0]) +
            (isPM ? 12 : 0);
    final convertedTimeSlotString =
        "$convertedTimeSlot:${state.selectedSlot!.split(" ").first.split(":")[1]}";
    final result = await _repo.bookSession(
      doctorId,
      DateFormat('yyyy-M-d', 'en').format(state.selectedDate!),
      convertedTimeSlotString,
      state.selectedDuration!.split(" ").first,
      complainController.text,
    );
    result.fold(
      (error) {
        emit(state.copyWith(
            status: BookSessionStatus.error, errorMessage: error.message));
      },
      (success) {
        emit(state.copyWith(status: BookSessionStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    complainController.dispose();
    return super.close();
  }
}
