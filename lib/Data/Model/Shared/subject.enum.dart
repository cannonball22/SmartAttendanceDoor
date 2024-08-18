enum Subject {
  mathematics,
  physics,
  chemistry,
  biology,
  computerScience,
  english,
  history,
  geography,
  art,
  music,
  physicalEducation,
  economics,
  socialStudies,
  languageArts,
  environmentalScience
}

extension SubjectExtension on Subject {
  String get name {
    switch (this) {
      case Subject.mathematics:
        return 'Mathematics';
      case Subject.physics:
        return 'Physics';
      case Subject.chemistry:
        return 'Chemistry';
      case Subject.biology:
        return 'Biology';
      case Subject.computerScience:
        return 'Computer Science';
      case Subject.english:
        return 'English';
      case Subject.history:
        return 'History';
      case Subject.geography:
        return 'Geography';
      case Subject.art:
        return 'Art';
      case Subject.music:
        return 'Music';
      case Subject.physicalEducation:
        return 'Physical Education';
      case Subject.economics:
        return 'Economics';
      case Subject.socialStudies:
        return 'Social Studies';
      case Subject.languageArts:
        return 'Language Arts';
      case Subject.environmentalScience:
        return 'Environmental Science';
      default:
        return 'Unknown';
    }
  }
}
