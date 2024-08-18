enum ExamType {
  midTerm,
  finalTerm,
}

extension ExamTypeExtension on ExamType {
  String get name => toString().split('.').last;
}
