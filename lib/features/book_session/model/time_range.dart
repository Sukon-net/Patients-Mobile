import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_range.g.dart';

@JsonSerializable()
class TimeRange {
  final String start;
  final String end;

  TimeRange({required this.start, required this.end});

  String convertStartTo12Hour() {
    final date = DateFormat("HH:mm", 'en').parseStrict(start.trim());
    return DateFormat('hh:mm a', 'en').format(date);
  }

  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeRangeToJson(this);
}
