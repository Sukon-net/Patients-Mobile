class TopRated {
  final String avatar;
  final String doctorName;
  final String doctorTittle;
  final String category;
  final int appointments;
  final int numOfComments;
  final int numOfExperiences;
  final double rated;

  TopRated(
      {required this.avatar,
      required this.doctorName,
      required this.doctorTittle,
      required this.category,
      required this.appointments,
      required this.numOfComments,
      required this.numOfExperiences,
      required this.rated});
}
