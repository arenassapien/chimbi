class Alumno {
  late String courseId, userId;
  late UserProfile profile;
  Alumno({required this.courseId, required this.userId, required this.profile});

  factory Alumno.fromJson(Map<String, dynamic> parsedJson) {
    //print(DateTime.parse(parsedJson['fechaPrestamo'].toString()));
    return Alumno(
      courseId: parsedJson['courseId'].toString(),
      userId: parsedJson['userId'].toString(),
      profile: UserProfile.fromJson(parsedJson["profile"]),
    );
  }
}

class UserProfile {
  late String id, fullName, emailAddress, photoUrl;
  late bool verifiedTeacher;
  UserProfile(
      {required this.id,
      required this.fullName,
      required this.emailAddress,
      required this.photoUrl,
      required this.verifiedTeacher});

  factory UserProfile.fromJson(Map<String, dynamic> parsedJson) {
    //print(DateTime.parse(parsedJson['fechaPrestamo'].toString()));
    return UserProfile(
      id: parsedJson['id'].toString(),
      fullName: UserName.fromJson(parsedJson['name']).fullName.toString(),
      emailAddress: parsedJson['emailAddress']..toString(),
      photoUrl: parsedJson['photoUrl'].toString(),
      verifiedTeacher: false,
    );
  }
}

class UserName {
  late String givenName, familyName, fullName;
  UserName(
      {required this.givenName,
      required this.fullName,
      required this.familyName});
  factory UserName.fromJson(Map<String, dynamic> parsedJson) {
    //print(DateTime.parse(parsedJson['fechaPrestamo'].toString()));
    return UserName(
      fullName: parsedJson['fullName'].toString(),
      givenName: parsedJson['givenName'].toString(),
      familyName: parsedJson['familyName'].toString(),
    );
  }
}
