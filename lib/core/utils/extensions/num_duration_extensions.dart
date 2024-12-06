extension NumDurationExtensions on num {
  Duration get microseconds => Duration(microseconds: round());

  Duration get ms => (this * 1000).microseconds;

  Duration get seconds => (this * 1000 * 1000).microseconds;

  Duration get minutes => (this * 60).seconds;

  Duration get hours => (this * 60).minutes;

  Duration get days => (this * 24).hours;
}
