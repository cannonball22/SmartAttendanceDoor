enum SchoolClass {
  firstA,
  firstB,
  secondA,
  secondB,
  thirdA,
  thirdB,
  fourthA,
  fourthB,
  fifthA,
  fifthB,
  sixthA,
  sixthB,
  seventhA,
  seventhB,
  eighthA,
  eighthB,
  ninthA,
  ninthB,
  tenthA,
  tenthB,
  eleventhA,
  eleventhB,
  twelfthA,
  twelfthB,
  thirteenthA,
  thirteenthB,
  fourteenthA,
  fourteenthB,
  fifteenthA,
  fifteenthB,
  sixteenthA,
  sixteenthB
}

extension SchoolClassName on SchoolClass {
  String get name {
    switch (this) {
      case SchoolClass.firstA:
        return "1th A";
      case SchoolClass.firstB:
        return "1th B";
      case SchoolClass.secondA:
        return "2th A";
      case SchoolClass.secondB:
        return "2th B";
      case SchoolClass.thirdA:
        return "3th A";
      case SchoolClass.thirdB:
        return "3th B";
      case SchoolClass.fourthA:
        return "4th A";
      case SchoolClass.fourthB:
        return "4th B";
      case SchoolClass.fifthA:
        return "5th A";
      case SchoolClass.fifthB:
        return "5th B";
      case SchoolClass.sixthA:
        return "6th A";
      case SchoolClass.sixthB:
        return "6th B";
      case SchoolClass.seventhA:
        return "7th A";
      case SchoolClass.seventhB:
        return "7th B";
      case SchoolClass.eighthA:
        return "8th A";
      case SchoolClass.eighthB:
        return "8th B";
      case SchoolClass.ninthA:
        return "9th A";
      case SchoolClass.ninthB:
        return "9th B";
      case SchoolClass.tenthA:
        return "10th A";
      case SchoolClass.tenthB:
        return "10th B";
      case SchoolClass.eleventhA:
        return "11th A";
      case SchoolClass.eleventhB:
        return "11th B";
      case SchoolClass.twelfthA:
        return "12th A";
      case SchoolClass.twelfthB:
        return "12th B";
      case SchoolClass.thirteenthA:
        return "13th A";
      case SchoolClass.thirteenthB:
        return "13th B";
      case SchoolClass.fourteenthA:
        return "14th A";
      case SchoolClass.fourteenthB:
        return "14th B";
      case SchoolClass.fifteenthA:
        return "15th A";
      case SchoolClass.fifteenthB:
        return "15th B";
      case SchoolClass.sixteenthA:
        return "16th A";
      case SchoolClass.sixteenthB:
        return "16th B";
    }
  }
}
