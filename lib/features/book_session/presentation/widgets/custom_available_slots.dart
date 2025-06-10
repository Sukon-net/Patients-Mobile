import 'package:clients/features/book_session/presentation/widgets/available_slot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvailableSlots extends StatelessWidget {
  const CustomAvailableSlots({
    super.key,
    required this.availableSlots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final List<String> availableSlots;
  final String? selectedSlot;
  final void Function(String? slot) onSlotSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 16.h,
          runSpacing: 16.w,
          children: List.generate(
            availableSlots.length,
            (index) => AvailableSlotCard(
              text: availableSlots[index],
              isSelected: selectedSlot != null &&
                  selectedSlot!.trim() == availableSlots[index].trim(),
              onSlotSelected: (_) => onSlotSelected(availableSlots[index]),
            ),
          ),
        ),
      ),
    );
  }
}
